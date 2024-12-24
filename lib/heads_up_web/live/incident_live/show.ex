defmodule HeadsUpWeb.IncidentLive.Show do
  use HeadsUpWeb, :live_view

  alias HeadsUp.Incidents

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _uri, socket) do
    incident = Incidents.get_incident(id)

    socket =
      socket
      |> assign(:incident, incident)
      |> assign(:page_title, incident.name)
      |> assign(:urgent_incidents, Incidents.urgent_incidents(incident))

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="incident-show">
      <div class="incident">
        <img src={@incident.image_path} />
        <section>
          <div class="text-lime-600 border-lime-600">
            <%= @incident.status %>
          </div>
          <header>
            <h2><%= @incident.name %></h2>
            <div class="priority">
              1
            </div>
          </header>
          <div class="description">
            <%= @incident.description %>
          </div>
        </section>
      </div>
      <div class="activity">
        <div class="left"></div>
        <div class="right">
          <ul>
            <.urgent_incidents incidents={@urgent_incidents} />
          </ul>
        </div>
      </div>
    </div>
    """
  end

  def urgent_incidents(assigns) do
    ~H"""
    <section>
      <h4>Urgent Incidents</h4>
      <ul class="incidents">
        <li :for={incident <- @incidents}>
          <img src={incident.image_path} />
          <%= incident.name %>
        </li>
      </ul>
    </section>
    """
  end
end
