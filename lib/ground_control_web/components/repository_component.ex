defmodule GroundControlWeb.RepositoryComponent do
  use GroundControlWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <div class="p-2 xl:w-1/2 w-full">
      <div class="p-4 bg-gray-100 rounded h-full items-center flex flex-auto flex-row items-center">
        <div class="flex-initial">
          <%= case @repo["status"] do %>
            <% "running" -> %>
              <svg class="animate-spin text-yellow-500 w-8 h-8 flex-shrink-0 mr-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
              </svg>

            <% "failure" -> %>
              <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="text-red-500 w-8 h-8 flex-shrink-0 mr-4" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>

            <% _ -> %>
              <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="text-green-500 w-8 h-8 flex-shrink-0 mr-4" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.828 14.828a4 4 0 01-5.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>

          <% end %>
        </div>
        <div class="flex flex-auto flex-row justify-between items-center content-center">
          <span class="text-2xl title-font font-medium"><%= @repo["name"] %></span>

          <a href="https://github.com/<%= @repo["owner"] %>/<%= @repo["name"] %>/commit/<%= @repo["sha"] %>" target="_blank" class="text-gray-300 title-font lowercase font-medium"><%= @repo["sha"] %></a>
        </div>
      </div>
    </div>
    """
  end
end
