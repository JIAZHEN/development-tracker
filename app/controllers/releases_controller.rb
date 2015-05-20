class ReleasesController < ApplicationController

  ORGANISATION = "globaldev".freeze

  after_action :slack_post, :only => [:create, :update_status]

  def new
    @repositories = Repository.all
    @environments = Environment.all
    @release = Release.new
  end

  def create
    release_params = params["release"]
    release = Release.create(:environment_id => params["release"]["environment"],
      :jira_number => params["release"]["jira_number"],
      :qa => params["release"]["qa"],
      :description => params["release"]["description"],
      :status_id => Status::WAIT_TO_DEPLOY,
      :username => current_username)
    create_projects(release)
    flash[:success] = "Thank you, the request has been submitted. It should be deployed shortly."
    redirect_to new_release_path
  end

  def edit
    @release = Release.find(params[:id])
    @repositories = Repository.all
    @environments = Environment.all
    render :new
  end

  def index
    @releases = Release.page params[:page]
    @statuses = Status.all if ops?

  end

  def get_branches
    repository = Repository.find_by(name: params["repository"])
    branches = if params["type"] == "sync"
      sync_branches_from_github(repository)
    else
      repository.active_branches
    end
    respond_with_json branches
  end

  def update_status
    release = Release.find(params["release_id"])
    release.update(status_id: params["status_id"])
    result = { colour: release.status_colour, name: release.status.name }
    respond_with_json result
  end

  private

  def respond_with_json(data)
    respond_to do |format|
      format.json { render json: data, status: 200 }
    end
  end

  def sync_branches_from_github(repository)
    client.branches("#{ORGANISATION}/#{repository.name}").map do |branch|
      repository.branches.find_or_create_by(name: branch.name)
    end
  end

  def create_projects(release)
    project_params = params["release"]["projects"]
    projects = project_params["branches"].zip(project_params["shas"],
      project_params["deployment_instructions"],
      project_params["rollback_instructions"])
    projects.map do |project|
      release.projects.find_or_create_by(:branch_id => project[0], :sha => project[1],
        :deployment_instruction => project[2],
        :rollback_instruction => project[3] )
    end
  end

end
