#!/bin/sh -x

if [ -d "../data" ]
  then echo -n ""
  else exit 1
fi

if [ -f "../data/alloclist.txt" ]
  then echo "alloclist already loaded"
  else wget -c "http://ftp.ripe.net/pub/stats/ripencc/membership/alloclist.txt" -O "../data/alloclist.txt"
fi

cat "../data/alloclist.txt" | awk '{ 
	if ( ! hadzven == 1 ) hadzven = 0;
	celalinka = $0;
	if ( ! headerlinka ) headerlinka = 0;
	if ( substr( celalinka, 1, 1) != " " && length(celalinka) != 0 ) {
		hadzven = 0;
		headerlinka = 0;
	}
	if ( length("sk.orange") == length(celalinka) )  orangesk = index(celalinka, "sk.orange");
	if ( length("fr.telecom") == length(celalinka) ) orangefr = index(celalinka, "fr.telecom");
	if ( orangefr == 1 || orangesk == 1 || hadzven == 1 ) {
		if ( headerlinka > 2 && length(celalinka) > 0 ) print $2;
		headerlinka = headerlinka + 1;
		hadzven = 1;
		orangefr = 0;
		orangesk = 0;
	};
}' > "../tables/orange.txt"
