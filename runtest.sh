
hosts=(`php config/config.php domains`)
tags=(`php config/config.php tags`)

# File and path names, change as desired
resultDir="results"
resultFile="results.html"

# Store some date information for later use in the presentation file
fancyDate=$(date +"%a, %b. %d %Y %I:%M %p")

# Create a new directory for the results based on the current date and time
newDir=$(date +"%y-%m-%d-%H%M%S")
dirPath=$resultDir/$newDir

# Echo the start time out to the terminal (for those who may be watching)
start=$(date +"%m-%d-%y %T")
echo "Start time : $start"

# Make the destination directories
mkdir -p $dirPath
mkdir -p $dirPath/xml

# Create the presentation file and write the head and top contents
indexFile=$dirPath/index.html
touch $indexFile
echo "<!DOCTYPE HTML><html><head><title>Behat Test Results</title><link rel=\"stylesheet\" type=\"text/css\" href=\"../../assets/style.css\" /></head><body><div id=\"head\"><h1>Behat Test Results</h1><div>$fancyDate</div></div><div id=\"content\">" >> $indexFile

# Loop through the directories looking for behat to run
i=0
for item in ${hosts[*]}
do

  tag=${tags[$i]}

  sed -e 's/##TAGS##/'$tag'/p' -e 's/##DOMAIN##/'$item'/p' template-behat.yml > behat.yml
  echo "########## RUNNING BEHAT FOR $item ##########"
 
  # Make a new directory for the domain
  mkdir $dirPath/$item
 
  # Create an iframe within our presentation page to show this domains results.html
  echo "<section><h2>$item</h2><iframe src=\"../../$dirPath/$item/$resultFile\"></iframe></section>" >> $indexFile
 
    # Run the behat tests for this domain
    # Here we are outputting the 
    #    - pretty format to the terminal
    #    - html format to our results.html files
    #    - junit-like xml into the xml directory (used for other test results analysis)
   bin/behat -f pretty,html --out ,$dirPath/$item/$resultFile,$dirPath/$item/$resultFile,$dirPath/$item/$resultFile --expand --no-paths
 
   i=$((i + 1))
done

# Close out the presentation page html
echo "</div></body></html>" >> $indexFile
 
# Zip up the test result contents
#zip -rq $dirPath.zip $dirPath/*
 
# output the finish date time to the terminal
finish=$(date +"%m-%d-%y %T")
echo "Finish time : $finish"
