require "serverspec"
require "docker"
require_relative "spec_helper"

describe "Dockerfile" do
  before(:all) do
    @image = Docker::Image.build_from_dir(File.expand_path("../..", __FILE__))

    set :os, family: :alpine
    set :backend, :docker
    set :docker_image, @image.id
  end

  describe "build" do
    it "has author defined" do
      expect(@image.json["Author"]).to include("Jason Sallis")
    end

    it "installs correct version of Alpine" do
      expect(command("cat /etc/alpine-release").stdout).to include(ALPINE_VERSION)
    end

    it "installs python" do
      expect(package("python")).to be_installed
    end

    it "installs pip" do
      expect(package("py-pip")).to be_installed
    end

    it "installs jenkins job builder" do
      expect(package("jenkins-job-builder")).to be_installed.by("pip").with_version(JENKINS_JOB_BUILDER_VERSION)
    end
  end

  describe "run" do
    it "has python 2 installed" do
      expect(command("python --version").stderr).to match(/^Python 2/)
    end

    it "has jenkins job builder #{VERSION} installed" do
      expect(command("jenkins-jobs --version").stderr).to match(/^Jenkins Job Builder version: #{JENKINS_JOB_BUILDER_VERSION}/)
    end
  end
end
