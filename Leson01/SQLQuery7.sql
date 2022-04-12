/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (9) [ord_no]
      ,[item_no]
      ,[qty]
  FROM [lesson01].[dbo].[order_details]
  DELETE FROM order_details
  go