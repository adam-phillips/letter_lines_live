defmodule LetterLinesLiveWeb.PageLive do
  use LetterLinesLiveWeb, :live_view

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    game = LetterLinesElixir.generate_game()

    socket =
      socket
      |> assign(:game, game)
      |> assign(:tile_size, 50)
      |> assign(:border_size, 5)

    {:ok, socket}
  end

  def board_width(%{game: game, tile_size: tile_size, border_size: border_size}) do
    (tile_size + border_size) * game.board_state.width + border_size
  end

  def board_height(%{game: game, tile_size: tile_size, border_size: border_size}) do
    (tile_size + border_size) * game.board_state.height + border_size
  end

  def display_tile(%{game: game} = assigns, x_index, y_index) do
    case LetterLinesElixir.BoardState.get_display_letter_at(game.board_state, x_index, y_index) do
      :none ->
        ""

      :hidden ->
        # @ expands variables to the same as `assigns.tile_size` -> this is a macro
        # phx-value pushes the value into values available to `handle_event`
        ~E"""
          <rect width="<%= @tile_size %>" height="<%= @tile_size %>" x="<%= tile_origin(assigns, x_index) %>"
          y="<%= tile_origin(assigns, y_index) %>" class="hidden-letter-tile"
          phx-click="tile_clicked" phx-value-x-index="<%= x_index %>" phx-value-y-index="<%= y_index %>" />
        """

      # Commented temporarily because the unused var error is annoying
      _letter ->
        ~E"""
          <rect width="<%= @tile_size %>" height="<%= @tile_size %>" x="<%= tile_origin(assigns, x_index) %>" y="<%= tile_origin(assigns, y_index) %>" class="exposed-letter-tile" />
        """
    end
  end

  def tile_origin(%{tile_size: tile_size, border_size: border_size}, index) do
    (tile_size + border_size) * index + border_size
  end

  @impl Phoenix.LiveView
  def handle_event("tile_clicked", values, socket) do
    game = socket.assigns.game
    IO.inspect(values)
    socket = assign(socket, :game, game)

    # TODO: get word that was clicked and set revealed true; function should be added to BoardState
    {:noreply, socket}
  end

  # TODO add handle_event for button click - this will reveal word that contains the clicked letter
end
