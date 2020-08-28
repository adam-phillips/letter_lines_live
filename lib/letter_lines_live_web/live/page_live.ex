defmodule LetterLinesLiveWeb.PageLive do
  use LetterLinesLiveWeb, :live_view

  alias LetterLinesElixir.BoardState
  alias LetterLinesElixir.BoardWord
  alias LetterLinesElixir.GameState

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    %GameState{board_state: board_state} = game = LetterLinesElixir.generate_game()

    available_letters =
      board_state
      |> BoardState.longest_word()
      |> BoardWord.get_word()
      |> String.to_charlist()
      |> Enum.map(fn letter -> List.to_string([letter]) end)
      |> Enum.shuffle()

    socket =
      socket
      |> assign(:game, game)
      |> assign(:available_letters, available_letters)
      |> assign(:selected_letters, [])
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

  def available_letters_width(%{available_letters: available_letters, tile_size: tile_size, border_size: border_size}) do
    (tile_size + border_size) * length(available_letters) + border_size
  end

  def available_letters_height(%{tile_size: tile_size, border_size: border_size}) do
    border_size * 2 + tile_size
  end

  def display_tile(%{game: game} = assigns, x_index, y_index) do
    case BoardState.get_display_letter_at(game.board_state, x_index, y_index) do
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

      letter ->
        ~E"""
          <svg width="<%= @tile_size %>" height="<%= @tile_size %>" x="<%= tile_origin(assigns, x_index) %>" y="<%= tile_origin(assigns, y_index) %>">
            <rect width="<%= @tile_size %>" height="<%= @tile_size %>"  class="exposed-letter-tile" />
            <text class="exposed-letter" x="50%" y="50%" dominant-baseline="middle" text-anchor="middle"><%= letter %></text>
          </svg>
        """
    end
  end

  @doc """
  Display the all letters that are available for use in guessing words.
  """
  def display_available_letters(%{available_letters: available_letters} = assigns, x_index) do
    ~E"""
      <svg width="<%= @tile_size %>" height="<%= @tile_size %>" x="<%= tile_origin(assigns, x_index) %>" y="<%= @border_size %>">
        <rect width="<%= @tile_size %>" height="<%= @tile_size %>"  class="exposed-letter-tile" />
        <text class="exposed-letter" x="50%" y="50%" dominant-baseline="middle" text-anchor="middle"><%= Enum.at(available_letters, x_index) %></text>
      </svg>
    """
  end

  def tile_origin(%{tile_size: tile_size, border_size: border_size}, index) do
    (tile_size + border_size) * index + border_size
  end

  @impl Phoenix.LiveView
  def handle_event("guess", %{"submit_word" => %{"word_guess" => guess}}, %{assigns: %{game: game}} = socket) do
    game =
      case BoardState.reveal_word(game.board_state, guess) |> IO.inspect() do
        {:ok, %BoardState{} = board_state} -> %GameState{game | board_state: board_state}
        {:error, :nothing_revealed} -> game
      end

    {:noreply, assign(socket, :game, game)}
  end

  @impl Phoenix.LiveView
  def handle_event("tile_clicked", _values, socket) do
    {:noreply, socket}
  end
end
