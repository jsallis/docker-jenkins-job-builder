require "serverspec"
require "docker"
require_relative "spec_helper"

describe "Dockerfile" do
  before(:all) do
    @image = Docker::Image.build_from_dir(File.expand_path("../..", __FILE__))

    set :os, family: :debian
    set :backend, :docker
    set :docker_image, @image.id
  end

  describe "build" do
    it "has author defined" do
      expect(@image.json["Author"]).to include("Jason Sallis")
    end

    it "sets correct working directory" do
      expect(@image.json["Config"]["WorkingDir"]).to eq("/jenkins-job-builder")
    end

    it "runs commands to install jenkins job builder" do
      expect(@image.json["ContainerConfig"]["Cmd"]).to include("pip install -r requirements.txt && python setup.py install")
    end
  end

  describe "run" do
    it "has python 2 installed" do
      expect(command("python --version").stderr).to match(/^Python 2/)
    end

    it "has jenkins job builder #{VERSION} installed" do
      expect(command("jenkins-jobs --version").stderr).to match (/^Jenkins Job Builder version: #{VERSION}/)
    end
  end
end
