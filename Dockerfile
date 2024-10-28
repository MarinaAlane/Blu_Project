# Dockerfile

# Use a imagem base com a versão correta do Ruby
FROM ruby:3.2.0-slim

# Instala dependências do sistema e Node.js para suporte ao Rails
RUN apt-get update -qq && apt-get install --no-install-recommends -y \
    build-essential \
    libpq-dev \
    nodejs \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copia o Gemfile e o Gemfile.lock para instalar as gems primeiro
COPY Gemfile Gemfile.lock ./

# Instala o Bundler e as gems do projeto, incluindo o Rails
RUN gem install bundler && bundle install

# Copia o restante do código do aplicativo para o diretório de trabalho
COPY . /app
WORKDIR /app

# Configura o ambiente para produção (ou `development`, conforme necessário)
ENV RAILS_ENV=development
ENV SECRET_KEY_BASE=dummy_key

# Compila os assets (caso necessário apenas para produção)
# RUN bundle exec rails assets:precompile

# Comando padrão para iniciar o container (substituível para comandos personalizados, como db:migrate ou rspec)
ENTRYPOINT ["bundle", "exec"]

# Comando padrão para iniciar o servidor (use o rails ou puma conforme sua preferência)
CMD ["rails", "server", "-b", "0.0.0.0"]
