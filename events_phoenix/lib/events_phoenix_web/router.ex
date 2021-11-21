defmodule EventsPhoenixWeb.Router do
  use EventsPhoenixWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {EventsPhoenixWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EventsPhoenixWeb do
    pipe_through :browser

    resources "/events", EventController

    get "/", PageController, :index
  end

  scope "/api", EventsPhoenixWeb.EventsApi, as: :events_api do
    pipe_through :api

    resources "/events", EventController
  end

  # Other scopes may use custom stacks.
  # scope "/api", EventsPhoenixWeb do
  #   pipe_through :api
  # end

  # :scope defaults to "/admin"
  # :pipe_through defaults to kaffy's [:kaffy_browser]
  # when providing pipelines, they will be added after :kaffy_browser
  # so the actual pipe_through for the previous line is:
  # [:kaffy_browser, :some_plug, :authenticate]
  use Kaffy.Routes, scope: "/admin" #, pipe_through: [:some_plug, :authenticate]


  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: EventsPhoenixWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
