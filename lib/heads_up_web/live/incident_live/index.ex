defmodule HeadsUpWeb.IncidentLive.Index do
  use HeadsUpWeb, :live_view

  alias HeadsUp.Incidents
  import HeadsUpWeb.CustomComponents

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        incidents: Incidents.list_incidents(),
        page_title: "Incidents"
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="incident-index">
      <.headline>
        <.icon name="hero-trophy-mini" /> 25 Incidents Resolved This Month!
        <:tagline :let={vibe}>
          Thanks for pitching in. <%= vibe %>
        </:tagline>
      </.headline>
      <div class="incidents">
        <.incident_card :for={incident <- @incidents} incident={incident} />
      </div>
    </div>
    """
  end

  slot :inner_block, required: true
  slot :tagline

  def headline(assigns) do
    assigns = assign(assigns, :emoji, ~w(😇 🙃 🥰) |> Enum.random())

    ~H"""
    <div class="headline">
      <h1>
        <%= render_slot(@inner_block) %>
      </h1>
      <div :for={tagline <- @tagline} class="tagline">
        <%= render_slot(tagline, @emoji) %>
      </div>
    </div>
    """
  end

  attr :incident, HeadsUp.Incident

  def incident_card(assigns) do
    ~H"""
    <div class="card">
      <img src={@incident.image_path} />
      <h2><%= @incident.name %></h2>
      <div class="details">
        <div class="priority">
          <%= @incident.priority %>
        </div>
        <.badge status={@incident.status} />
      </div>
    </div>
    """
  end
end
