# Usar a imagem base do Node.js
FROM node:14

# Definir o diretório de trabalho dentro do container
WORKDIR /app

# Copiar os arquivos package.json e package-lock.json
COPY package*.json ./

# Instalar as dependências do projeto
RUN npm install

# Copiar o restante do código da aplicação
COPY . .

# Construir a aplicação para produção
RUN npm run build

# Instalar o servidor estático para servir a aplicação
#RUN npm install -g serve

# Expor a porta usada pelo servidor
#EXPOSE 3001

# Instalar o servidor estático para servir a aplicação
#RUN npm install -g serve

# Comando para iniciar o servidor
#CMD ["serve", "-s", "build"]


# Usa uma imagem do Nginx para servir a aplicação
FROM nginx:alpine

# Copia os arquivos compilados para a pasta padrão do Nginx
COPY --from=0 /app/build /usr/share/nginx/html

# Expõe a porta que a aplicação vai rodar
EXPOSE 80

# Comando para iniciar o Nginx
CMD ["nginx", "-g", "daemon off;"]