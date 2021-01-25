defmodule GroundControlWeb.RepositoryComponent do
  use GroundControlWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <div class="p-2 sm:w-1/2 w-full">
      <div class="bg-gray-100 rounded flex p-4 h-full items-center">
        <%= case @repo.status do %>
          <% "running" -> %>
            <div class="flex-initial">
              <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="animate-ping text-yellow-500 w-8 h-8 flex-shrink-0 mr-4" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
            </div>

          <% "failure" -> %>
            <div class="flex-initial">
              <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="text-red-500 w-8 h-8 flex-shrink-0 mr-4" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
            </div>

          <% _ -> %>
            <div class="flex-initial">
              <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="text-green-500 w-8 h-8 flex-shrink-0 mr-4" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.828 14.828a4 4 0 01-5.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
            </div>

        <% end %>
        <div class="flex-initial">
          <span class="text-2xl title-font font-medium"><%= @repo.name %></span>
        </div>
        <div class="flex-auto text-right">
          <span class="text-gray-300 title-font lowercase font-medium place-self-end"><%= @repo.sha %></span>
        </div>
      </div>
    </div>
    """
  end
end
