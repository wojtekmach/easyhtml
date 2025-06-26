defmodule EasyHTML.MixProject do
  use Mix.Project

  def project do
    [
      app: :easyhtml,
      version: "0.4.0-dev",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
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

  def cli do
    [
      preferred_envs: [
        docs: :docs,
        "hex.publish": :docs
      ]
    ]
  end

  defp deps do
    [
      {:lazy_html, "~> 0.1.3"},
      {:ex_doc, ">= 0.0.0", only: :docs}
    ]
  end
end
