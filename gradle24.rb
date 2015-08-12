class Gradle24 < Formula
  desc "Gradle build automation tool"
  homepage "https://www.gradle.org/"
  url "https://services.gradle.org/distributions/gradle-2.4-bin.zip"
  sha256 "c4eaecc621a81f567ded1aede4a5ddb281cc02a03a6a87c4f5502add8fc2f16f"

  conflicts_with "gradle", :because => "Differing version of same formula"

  def install
    libexec.install %w[bin lib]
    bin.install_symlink libexec+"bin/gradle"
  end

  test do
    system "#{bin}/gradle", "-version"
  end
end
