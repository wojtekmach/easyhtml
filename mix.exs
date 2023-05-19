defmodule EasyHTML.MixProject do
  use Mix.Project

  def project do
    [
      app: :easyhtml,
      version: "0.2.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      preferred_cli_env: [
        docs: :docs,
        "hex.publish": :docs
      ],
      docs: [
        main: "readme",
        extras: ["README.md", "CHANGELOG.md"]
      ],
      package: [
        description: "EasyHTML makes working with HTML easy.",
        licenses: ["Apache-2.0"],
        links: %{
          "GitHub" => "https://github.com/wojtekmach/easyhtml"
        }
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:floki, "~> 0.30"},
      {:ex_doc, ">= 0.0.0", only: :docs}
    ]
  end
end
