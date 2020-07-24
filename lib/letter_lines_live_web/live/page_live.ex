defmodule LetterLinesLiveWeb.PageLive do
  use LetterLinesLiveWeb, :live_view

  @impl true
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
        ~E"""
          <rect width="<% @tile_size %>" height="<%= @tile_size %>" class="hidden-letter-tile" />
        """

      # Commented temporarily because the unused var error is annoying
      _letter ->
        ~E"""
          <rect width="<% @tile_size %>" height="<%= @tile_size %>" class="exposed-letter-tile" />
        """
    end
  end
end
