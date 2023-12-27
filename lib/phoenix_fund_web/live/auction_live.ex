defmodule PhoenixFundWeb.AuctionLive do
  use PhoenixFundWeb, :live_view

  @topic "auction"

  def mount(params, session, socket) do
    PhoenixFundWeb.Endpoint.subscribe(@topic)
   {:ok, assign(socket, :raised, 0)}
  end

  def handle_info(%{topic: @topic, payload: raised}, socket) do
    {:noreply, assign(socket, :raised, raised)}
  end

  def handle_event("donate-1", _, socket) do
    raised = socket.assigns.raised + 1
    PhoenixFundWeb.Endpoint.broadcast_from(self(), @topic, "donate_event", raised)
    {:noreply, assign(socket, :raised, raised)}
  end

  def handle_event("donate-5", _, socket) do
    raised = socket.assigns.raised + 5
    PhoenixFundWeb.Endpoint.broadcast_from(self(), @topic, "donate_event", raised)
    {:noreply, assign(socket, :raised, raised)}
  end

  def handle_event("donate-10", _, socket) do
    raised = socket.assigns.raised + 10
    PhoenixFundWeb.Endpoint.broadcast_from(self(), @topic, "donate_event", raised)
    {:noreply, assign(socket, :raised, raised)}
  end

  def handle_event("donate-100", _, socket) do
    raised = socket.assigns.raised + 100
    PhoenixFundWeb.Endpoint.broadcast_from(self(), @topic, "donate_event", raised)
    {:noreply, assign(socket, :raised, raised)}
  end

  def render(assigns) do
    ~L"""
       <h1 for="price" class="text-2xl font-bold text-gray-900 sm:pr-12">Cabinet of Curiosities</h1>
       <div id="auction" class="relative mt-2 rounded-md shadow-sm">
          <div class="w-full bg-gray-200 rounded-full dark:bg-gray-700">
            <span class="bg-blue-600 text-xs font-medium text-blue-100 text-center p-0.5 leading-none rounded-full" style="width: <%= @raised %>%">
              $<%= @raised %> USD
            </span>
          </div>

          <button class="rounded-md bg-indigo-600 px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600" phx-click="donate-1"> $1 </button>
          <button class="rounded-md bg-indigo-600 px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600" phx-click="donate-5"> $5 </button>
          <button class="rounded-md bg-indigo-600 px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600" phx-click="donate-10"> $10 </button>
          <button class="rounded-md bg-indigo-600 px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600" phx-click="donate-100"> $100 </button>
        </div>
    """
  end
 end
