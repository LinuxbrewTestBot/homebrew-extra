class AwsVault < Formula
  desc "Securely store and access AWS credentials in development environments"
  homepage "https://github.com/99designs/aws-vault"
  url "https://github.com/99designs/aws-vault/archive/v4.6.0.tar.gz"
  sha256 "058f20dcfafad2641c35b6970909d0dedd71db66450d820f8f1fb457abcf50a0"

  bottle do
    cellar :any_skip_relocation
    sha256 "99a3988e3a2134ae486c1cc8f3aa1e7e12f70c845c7d465d04c5267183a28fc8" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    ENV["GOOS"] = "linux"
    ENV["GOARCH"] = "amd64"

    system "make", "build"
    bin.install "aws-vault"

    zsh_completion.install "completions/zsh/_aws-vault"
    bash_completion.install "completions/bash/aws-vault"
  end

  test do
    assert_match("aws-vault: error: required argument 'profile' not provided, try --help", shell_output("#{bin}/aws-vault login 2>&1", 1))
  end
end
