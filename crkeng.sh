# This is a shellscript to make the Plains Cree - English dictionary
# into an analyser. Command to use this script:
# sh crkeng.sh

echo ""
echo ""
echo "---------------------------------------------------"
echo "Shellscript to make a transducer of the dictionary."
echo ""
echo "It writes a lexc file to bin, containing the line	 "
echo "LEXICON Root										 "
echo "Thereafter, it picks lemma and first translation	 "
echo "of the dictionary, adds them to this lexc file,	 "
echo "and compiles a transducer bin/crkeng.fst		 "
echo ""
echo "Usage:"
echo "lookup bin/crkeng.fst"
echo "---------------------------------------------------"
echo ""
echo ""

echo "LEXICON Root" > bin/crkeng.lexc
cat src/*crkeng.xml | \
tr -d '\!'           | \
tr '[:;]' ','           | \
grep '^ *<[lt][ >]'  | \
sed 's/^ *//g;'      | \
sed 's/<l /™/g;'     | \
tr '\n' '£'          | \
sed 's/£™/€/g;'      | \
tr '€' '\n'          | \
tr '<' '>'           | \
cut -d'>' -f2,6      | \
tr '>' ':'           | \
tr ' ' '_'           | \
sed 's/$/ # ;/g;'    >> bin/crkeng.lexc        

#xfst -e "read lexc < bin/crkeng.lexc"

printf "read lexc < bin/crkeng.lexc \n\
invert net \n\
save stack bin/crkeng.fst \n\
quit \n" > tmpfile
xfst -utf8 < tmpfile
rm -f tmpfile



