# STAGE 1: BUILD
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

COPY . .
RUN dotnet restore "MvcAzureDocker.csproj"
RUN dotnet publish "MvcAzureDocker.csproj" -c Release -o /app/publish --no-restore

# STAGE 2: RUNTIME
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app

COPY --from=build /app/publish .

ENV ASPNETCORE_HTTP_PORTS=8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "MvcAzureDocker.dll"]
