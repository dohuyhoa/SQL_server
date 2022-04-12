USE [master]
GO

/****** Object:  Database [lesson01]    Script Date: 3/30/2022 6:45:55 AM ******/
CREATE DATABASE [lesson01]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'lesson01', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\lesson01.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'lesson01_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\lesson01_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [lesson01].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [lesson01] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [lesson01] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [lesson01] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [lesson01] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [lesson01] SET ARITHABORT OFF 
GO

ALTER DATABASE [lesson01] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [lesson01] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [lesson01] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [lesson01] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [lesson01] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [lesson01] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [lesson01] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [lesson01] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [lesson01] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [lesson01] SET  DISABLE_BROKER 
GO

ALTER DATABASE [lesson01] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [lesson01] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [lesson01] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [lesson01] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [lesson01] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [lesson01] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [lesson01] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [lesson01] SET RECOVERY FULL 
GO

ALTER DATABASE [lesson01] SET  MULTI_USER 
GO

ALTER DATABASE [lesson01] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [lesson01] SET DB_CHAINING OFF 
GO

ALTER DATABASE [lesson01] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [lesson01] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [lesson01] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [lesson01] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO

ALTER DATABASE [lesson01] SET QUERY_STORE = OFF
GO

ALTER DATABASE [lesson01] SET  READ_WRITE 
GO

