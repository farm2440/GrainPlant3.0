SELECT 
  DISTINCTROW Format$([silo_cons].[when],'Long Date') AS [when_by_day], 
  [silos].[name] AS [silo_name], 
  Sum([silo_cons].[qty]) AS [sum_qty], 
  Count(*) AS [uses]
FROM 
  [silos] INNER JOIN [silo_cons] ON [silos].[id] = [silo_cons].[silo_id]
WHERE
  [silo_cons].[when] BETWEEN [:from_date] AND [:to_date]
GROUP BY 
  Format$([silo_cons].[when],'Long Date'), silos.name;
