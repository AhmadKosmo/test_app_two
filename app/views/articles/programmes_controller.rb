class ProgrammesController < ApplicationController

  def index
    # @programmes = Programme.all
    @programmes = Programme.paginate(page: params[:page], per_page: 8)
    @realisateurs = Realisateur.all

    if (params[:search])
      @programmes = Programme.where(titre: params[:search])
      @programme = @programmes.first
      render 'show'
    end

  end

  def new
    @programme = Programme.new
    @realisateurs = Realisateur.all

    @array_of_noms_realisateurs_ids_realisateurs =[]
    @realisateurs.each do |realisateur|
      a = [realisateur.nom, realisateur.id]
      @array_of_noms_realisateurs_ids_realisateurs.push(a)
    end

  end

  def create
    @programme = Programme.new(programme_params)

    if @programme.save
      flash[:success] = "Le Programme a bien été créé"
      redirect_to programme_path(@programme)
    else
      render 'new'
    end
  end

  def show
    if (params[:search])
      @programme = Programme.where(titre: params[:search])
      @realisateur = Realisateur.find(@programme.realisateur_id)
      params[:id] = @programme.ids
      params[:realisateur_id] = @programme.realisateur_id
    else
      @programme = Programme.find(params[:id])
    end
  end

  def edit
    if (params[:search])
      # @programme = Programme.where(titre: params[:search])
      # params[:id] = @programme.ids
    end

    @programme = Programme.find(params[:id])
    @realisateurs = Realisateur.all

    @array_of_noms_realisateurs_ids_realisateurs =[]
    @realisateurs.each do |realisateur|
      a = [realisateur.nom, realisateur.id]
      @array_of_noms_realisateurs_ids_realisateurs.push(a)
    end
  end

  def update
    @programme = Programme.find(params[:id])

    if @programme.update(programme_params)
      flash[:success] = "Programme a bien été modifié"
      redirect_to programme_path(@programme)
    else
      render 'edit'
    end
  end

  def destroy
    @programme = Programme.find(params[:id])
    @programme.destroy
    flash[:danger] = "Le programme a bien été supprimé"
    redirect_to programmes_path
  end

  private
  def programme_params
    params.require(:programme).permit(:titre, :type_programme, :classification, :realisateur_id)
  end
end
