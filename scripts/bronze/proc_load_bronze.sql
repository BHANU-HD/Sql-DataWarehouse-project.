/*
============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
=============================================================================

Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

create or alter procedure bronze.load_bronze as 
begin
     declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
     begin try
     print'-------------------------------------------------';
     print'loading crm tables';
     print'-------------------------------------------------';

     set @START_TIME = GETDATE();
     print'>>truncating table:bronze.crm_cust_info';
     TRUNCATE TABLE bronze.crm_cust_info;

     print'>>inserting table:bronze.crm_cust_info';
     BULK INSERT bronze.crm_cust_info
     FROM 'C:\Users\BHANU\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
     WITH (
           FIRSTROW = 2,
           FIELDTERMINATOR = ',',
           TABLOCK
     );
     set @END_TIME = GETDATE();
     PRINT'>> LOAD DURATION: ' + cast(DATEDIFF(second, @start_time,@end_time) as nvarchar) + 'seconds';
     print'>>-----------------';


     set @START_TIME = GETDATE();
     print'>>truncating table:bronze.crm_prd_info';
     TRUNCATE TABLE bronze.crm_prd_info;

     print'>>inserting table:bronze.crm_prd_info';
     BULK INSERT bronze.crm_prd_info
     FROM 'C:\Users\BHANU\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
     WITH (
           FIRSTROW = 2,
           FIELDTERMINATOR = ',',
           TABLOCK
     );
  
     set @END_TIME = GETDATE();
     PRINT'>> LOAD DURATION: ' + cast(DATEDIFF(second, @start_time,@end_time) as nvarchar) + 'seconds';
     print'>>-----------------';


     set @START_TIME = GETDATE();
     print'>>truncatint table:bronze.crm_sales_detail';
     TRUNCATE TABLE bronze.crm_sales_detail;

     print'>>inserting table:bronze.crm_sales_detail';
     BULK INSERT bronze.crm_sales_detail
     FROM 'C:\Users\BHANU\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
     WITH (
           FIRSTROW = 2,
           FIELDTERMINATOR = ',',
           TABLOCK
     );
     set @END_TIME = GETDATE();
     PRINT'>> LOAD DURATION: ' + cast(DATEDIFF(second, @start_time,@end_time) as nvarchar) + 'seconds';
     print'>>-----------------';



     print'-------------------------------------------------';
     print'loading erp tables';
     print'-------------------------------------------------';

     set @START_TIME = GETDATE();
     print'>> truncating table:bronze.erp_cust_az12:';
     TRUNCATE TABLE bronze.erp_cust_az12;
     
     print'>> inserting data into:bronze.erp_cust_az12';
     BULK INSERT bronze.erp_cust_az12
     FROM 'C:\Users\BHANU\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\cust_az12.csv'
     WITH (
           FIRSTROW = 2,
           FIELDTERMINATOR = ',',
           TABLOCK
     );
     set @END_TIME = GETDATE();
     PRINT'>> LOAD DURATION: ' + cast(DATEDIFF(second, @start_time,@end_time) as nvarchar) + 'seconds';
     print'>>-----------------';



     set @START_TIME = GETDATE();
     print'>>truncating table: bronze.erp_LOC_A101';
     TRUNCATE TABLE bronze.erp_LOC_A101;

     print'>>inserting table: bronze.erp_LOC_A101';
     BULK INSERT bronze.erp_LOC_A101
     FROM 'C:\Users\BHANU\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.csv'
     WITH (
           FIRSTROW = 2,
           FIELDTERMINATOR = ',',
           TABLOCK
     );
     set @END_TIME = GETDATE();
     PRINT'>> LOAD DURATION: ' + cast(DATEDIFF(second, @start_time,@end_time) as nvarchar) + 'seconds';
     print'>>-----------------';
 



     set @START_TIME = GETDATE();
     print'>>truncating table:bronze.erp_PX_CAT_G1V2';
     TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;

     print'>>iserting table:bronze.erp_PX_CAT_G1V2';
     BULK INSERT bronze.erp_PX_CAT_G1V2
     FROM 'C:\Users\BHANU\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv'
     WITH (
           FIRSTROW = 2,
           FIELDTERMINATOR = ',',
           TABLOCK
     );
     set @END_TIME = GETDATE();
     PRINT'>> LOAD DURATION: ' + cast(DATEDIFF(second, @start_time,@end_time) as nvarchar) + 'seconds';
     print'>>-----------------';
 
     SET @batch_end_time = GETDATE();
     PRINT '========================================';
     PRINT 'Loading Bronze Layer is Completed';
     PRINT '  - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
     PRINT '========================================';
     end try
     begin catch
          print'================================================';
          print'error occured during loading bronze layer';
          print'error message'+error_message();
          print 'error message' + cast(error_number() as nvarchar);
          print 'error message' + cast(error_state() as nvarchar);
          print'================================================';

     end catch

end



