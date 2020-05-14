defmodule EventsDashboardWeb.EventsLive do
  use EventsDashboardWeb, :live_view
  alias EventsDashboard.{Event, Repo}
  alias Phoenix.PubSub
  import Ecto.Changeset, only: [change: 2]
  import Ecto.Query

  def mount(_params, _session, socket) do
    PubSub.subscribe(EventsDashboard.PubSub, "update_all")

    {:ok, assign(socket, events: Event |> order_by([asc: :id]) |> Repo.all)}
  end

  def handle_info({:event_updated, id}, socket) do
    {:noreply, assign(socket, events: Event |> order_by([asc: :id]) |> Repo.all)}
  end

  def handle_event("update_event", %{"id" => id}, socket) do
    event = Repo.get(Event, id)
    Repo.update!(change(event, customer_updated: false, banking_details_updated: false, order_updated: false))

    PubSub.broadcast EventsDashboard.PubSub,  "update_all", {:start_workflow, %{id: id}}
    {:noreply, assign(socket, events: Event |> order_by([asc: :id]) |> Repo.all)}
  end

  def handle_info({:start_workflow, id}, socket) do
    :timer.sleep(1000)
    PubSub.broadcast(EventsDashboard.PubSub,  "update_all", {:update_order, %{id: id.id}})
    PubSub.broadcast(EventsDashboard.PubSub,  "update_all", {:update_banking_details, %{id: id.id}})
    PubSub.broadcast(EventsDashboard.PubSub,  "update_all", {:update_customer, %{id: id.id}})
    {:noreply, assign(socket, events: Event |> order_by([asc: :id]) |> Repo.all )}
  end

  def handle_info({:update_customer, id}, socket) do
    :timer.sleep(1000)
    event = Repo.get(Event, id.id)
    Repo.update!(change(event, customer_updated: true))

    PubSub.broadcast(EventsDashboard.PubSub,  "update_all", {:event_updated, %{id: id.id}})
    {:noreply, assign(socket, events: Event |> order_by([asc: :id]) |> Repo.all)}
  end

  def handle_info({:update_banking_details, id}, socket) do
    :timer.sleep(1000)
    event = Repo.get(Event, id.id)
    Repo.update!(change(event, banking_details_updated: true))

    PubSub.broadcast(EventsDashboard.PubSub,  "update_all", {:event_updated, %{id: id.id}})
    {:noreply, assign(socket, events: Event |> order_by([asc: :id]) |> Repo.all)}
  end

  def handle_info({:update_order, id}, socket) do
    :timer.sleep(1000)
    event = Repo.get(Event, id.id)
    Repo.update!(change(event, order_updated: true))

    PubSub.broadcast(EventsDashboard.PubSub,  "update_all", {:event_updated, %{id: id.id}})
    {:noreply, assign(socket, events: Event |> order_by([asc: :id]) |> Repo.all)}
  end
end
