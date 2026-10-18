FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY ["dotnet-crud.csproj", "./"]
RUN dotnet restore "dotnet-crud.csproj"

COPY . .
RUN dotnet publish "dotnet-crud.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app

COPY --from=build /app/publish .

EXPOSE 8080
ENTRYPOINT ["dotnet", "dotnet-crud.dll"]
