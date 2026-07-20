USE GMALHOT1;
GO

-- =======================================================================
-- KPI 1: Supplier OTIF (On-Time In-Full) Rate
-- Measures the % of shipments that arrived on/before the expected date 
-- AND with the exact quantity ordered to monitor vendor compliance.
-- =======================================================================
SELECT 
    s.SupplierName,
    COUNT(sh.ShipmentID) AS TotalShipments,
    SUM(CASE 
            WHEN sh.ActualDeliveryDate <= sh.ExpectedDeliveryDate 
             AND sh.QuantityReceived = sh.QuantityOrdered THEN 1 
            ELSE 0 
        END) * 100.0 / COUNT(sh.ShipmentID) AS OTIF_Percentage
FROM Shipments sh
JOIN Suppliers s ON sh.SupplierID = s.SupplierID
GROUP BY s.SupplierName;
GO

-- =======================================================================
-- KPI 2: Average Lead Time Variance by Supplier
-- Isolates operational bottlenecks by calculating the average days delayed.
-- =======================================================================
SELECT 
    s.SupplierName,
    AVG(DATEDIFF(day, sh.ExpectedDeliveryDate, sh.ActualDeliveryDate)) AS AvgDaysDelayed
FROM Shipments sh
JOIN Suppliers s ON sh.SupplierID = s.SupplierID
WHERE sh.ActualDeliveryDate IS NOT NULL
GROUP BY s.SupplierName
ORDER BY AvgDaysDelayed DESC;
GO