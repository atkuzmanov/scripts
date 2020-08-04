echo -Start file multiplication.
::copy "C:\Users\[User]\example-01.jpg" "C:\Users\[User]\Stuff\example-02.jpg"
::for /l %%x in (2, 1, 1000) do copy "C:\Users\[User]\example-01.jpg" "C:\Users\[User]\Stuff\example-%%x.jpg"
echo -End file multiplication.