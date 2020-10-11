# GS1 barcode check digit calculator
Implementation of the algorithm to calculate the check-digit of a GS1 barcodes

## GS1 EAN standard coding
The GS1 EAN standard coding requires that every well-formed code ends with a check-digit that will be used by barcode readers to interpret the code properly. The check-digit is a number between zero and nine and it is calculated according to the other digits in the code. The calculation algorithm is shown [here](https://www.gs1.org/services/how-calculate-check-digit-manually).

This repository contains the algorithms needed to calculate the check-digit of a GS1 barcode using different languages:
* [TSQL for SQL Server and Azure SQL Database](https://github.com/segovoni/GS1-barcode-check-digit-calculator/tree/master/TSQL)
* [Delphi](https://github.com/segovoni/GS1-barcode-check-digit-calculator/tree/master/Delphi)

## Why it is important to use barcodes to manage and move products
In order to scale, it's imperative that companies stay ahead of competition. So how can they identify, store, manage and deliver goods to customers efficiently? The answer is: Barcode! A barcode is the graphical representation of a sequence of numbers and other symbols. The representation is made by lines (bars) and spaces. A barcode typically consists of five parts and one of these is the check character, also known as the check digit. Handwriting this is a hard work, and is also susceptible to legibility problems, barcoding dramatically reduces human error, recognition errors and transcription errors.
