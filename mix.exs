defmodule ReadingTime.MixProject do
  use Mix.Project

  def project do
    [
      app: :reading_time,
      version: "0.1.1",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  defp description do
    """
    ReadingTime helps you estimate how long some text will take to be read.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["Ignacio Aguirrezabal"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/iaguirre88/reading_time",
        "Docs" => "https://hexdocs.pm/reading_time"
      }
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:stream_data, "~> 0.5", only: :test},
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false}
    ]
  end
end
