class TemplatesController < ApplicationController
  def index
    @templates = Template.all
  end

  def show
    @template = Template.find(params[:id])
  end

  def new
    @template = Template.new
    @tipos = Tipo.all
  end

  def create
    @template = Template.new(template_params)
    @template.docente = current_user
    if @template.save
      redirect_to @template
    else
      @tipos = Tipo.all
      render 'new'
    end
  end

  def edit
    @template = Template.find(params[:id])
  end

  def update
    @template = Template.find(params[:id])
    if @template.update(template_params)
      redirect_to @template
    else
      render 'edit'
    end
  end

  def destroy
    @template = Template.find(params[:id])
    @template.destroy
    redirect_to templates_path
  end

  #A criação de questões será feita dentro da view de criação de template, portanto, acho uma boa desição de design
  # usar o mesmo controller para os 2
  def add_questao
    @questao = @template.questaos.build
  end

  def update_questao
    @questao = @template.questaos.find(params[:questao_id])
    if @questao.update(questao_params)
      redirect_to @template, notice: 'Questão atualizada com sucesso.'
    else
      render edit
    end
  end

  def destroy_questao
    @questao = @template.questaos.find(params[:questao_id])
    @questao.destroy
    redirect_to @template
  end

   #A criação de questões será feita dentro da view de criação de template, portanto, acho uma boa desição de design
   # usar o mesmo controller para os 2

  def add_alternativa
    @alternativa = @template.questaos.alternativas.build
  end

  def update_alternativa
    @alternativa = @template.questaos.alternativas.find(params[:alternativa_id])
    if @alternativa.update(alternativa_params)
      redirect_to @template, notice: 'alternativa atualizada'
    end
    render edit
  end

  def destroy_alternativa
    @alternativa = @template.questaos.alternativas.find(params[:alternativa_id])
    @alternativa.destroy
    redirect_to @template
  end

  private

  def template_params
    params.require(:template).permit(:nome, questaos_attributes: [:id, :pergunta, :alternativas, :pontos, :fatorDeCorrecao, :alternativaCorreta, :tipo, :_destroy])
  end

  def questao_params
    params.require(:questao).permit(:pergunta, :pontos, :fatorDeCorrecao, :alternativaCorreta, :tipo, alternativa_attributes:[:id, :texto])
  end

  def alternativa_params
    params.require(:alternativa).permit(:texto)
  end
end
