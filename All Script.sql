
Select continent, location
From PortfolioPojectCovid..CovidDeaths
Where continent is not null 
Group by continent, location
Order by 1,2


-- Select data that I'm going to be using
Select location, date, total_cases, new_cases, total_deaths, population
From PortfolioPojectCovid.dbo.CovidDeaths
Where continent is not null
Order by 1, 2


-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country
Select location, date, total_cases, total_deaths, (Convert(float, total_deaths)/Convert(float, total_cases))*100 as DeathPercentage
From PortfolioPojectCovid.dbo.CovidDeaths
Where location = 'Vietnam' and continent is not null
Order by 1, 2


-- Looking at Total Cases vs Population
-- Shows what percentage of population got Covid 
Select location, date, population, total_cases, (Convert(float, total_cases)/population)*100 as PercentPopulationInfected
From PortfolioPojectCovid.dbo.CovidDeaths
--Where location = 'Vietnam'
Where continent is not null
Order by 1, 2


--Looking at Countries with Highest Infection Rate compared to Population
Select Location, Population, MAX(Convert(float, total_cases)) as HighestInfectionCount, Max(Convert(float, total_cases)/population*100) as PercentPopulationInfected
From PortfolioPojectCovid.dbo.CovidDeaths
Where continent is not null
Group by Location, Population
Order by PercentPopulationInfected desc


--Showing Countries with Highest Death Count per Population
Select Location, MAX(Convert(float, total_deaths)) as TotalDeathCount
From PortfolioPojectCovid.dbo.CovidDeaths
Where continent is not null
Group by Location
Order by TotalDeathCount desc


-- Break things donw by Continent
With CTE_Continent AS
(Select Continent, location, MAX(Convert(float, total_deaths)) as TotalDeathCount
From PortfolioPojectCovid..CovidDeaths
Where continent is not null
Group by continent, location
)

Select Continent, Sum(TotalDeathCount) as ContinentTotalDeathCount
From CTE_Continent
Group by continent
Order by 2 desc