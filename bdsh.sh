variable1=`echo $1`
variable2=`echo $2`
variable3=`echo $3`
variable4=`echo $4`
variable5=`echo $5`
nomdefichier="sh.db"

#Si il n'y a pas de parametre
if [ $variable1 == "" ];
then echo "bdsh.sh [-k] [-f <db_file>] (\nput <clef> <valeur> |\ndel <clef> |select [<expr>] )"
fi    

#Si -f n'est pas present
if [ $variable1 == "put" ];
then touch $nomdefichier
fi
if [ $variable1 == "put" ] && [ `grep -wc "$variable2 .*" $nomdefichier` -eq 0 ] && [ ! -f ${variable2} ] && [ ! -f ${variable3} ];
then echo "$variable2 $variable3" >> $nomdefichier
fi
if [ $variable1 == "put" ] && [ `grep -wc "$variable2 .*" $nomdefichier` -eq 1 ] && [ ! -f ${variable2} ] && [ ! -f ${variable3} ];  
then sed -ie  "s/$variable2 .*/$variable2 $variable3/g" $nomdefichier
    rm ""$nomdefichier"e"
fi 
if [ $variable1 == "del" ];
then sed -ie "s/$variable2.*/$variable2/g" $nomdefichier 
    rm ""$nomdefichier"e"
fi
if [ $variable1 == "select" ] && [ ! -f ${variable2} ];
then grep "$variable2 *." $nomdefichier | cut -d " " -f 2 
fi
if [ $variable1 == "select" ] && [ -f ${variable2} ];
then  cut -d " " -f 2 $nomdefichier
fi


#Si -f est le premier argument
if [ $variable1 == "-f" ];
then touch $variable2
fi    
if [ $variable1 == "-f" ]
then nouvellebase=`echo $variable2`
    if [ $variable3 == "put" ] && [ `grep -wc "$variable4 .*" $nouvellebase` -eq 0 ] && [ ! -f ${variable4} ] && [ ! -f ${variable5} ];
    then echo "$variable4 $variable5" >> $nouvellebase
    fi
    if [ $variable3 == "put" ] && [ `grep -wc "$variable4 .*" $nouvellebase` -eq 1 ] && [ ! -f ${variable4} ] && [ ! -f ${variable5} ];  
    then sed -ie  "s/$variable4 .*/$variable4 $variable5/g" $nouvellebase
	rm ""$nouvellebase"e"
    fi 
    if [ $variable3 == "del" ];
    then sed -ie "s/$variable4.*/$variable4/g" $nouvellebase 
	rm ""$nouvellebase"e"
    fi
    if [ $variable3 == "select" ] && [ ! -f ${variable4} ];
    then grep "$variable4 *." $nouvellebase | cut -d ' ' -f 2 
    fi
    if [ $variable3 == "select" ] && [ -f ${variable4} ];
    then  cut -d " " -f 2 $nouvellebase
    fi
fi

#Si -f est precede de put
if [ $variable4 == "-f" ] && [ $variable1 == "put" ]
then touch $variable5
    if [ `grep -wc "$variable2 .*" $variable5` -eq 0 ] && [ ! -f ${variable2} ] && [ ! -f ${variable3} ];
    then echo "$variable2 $variable3" >> $variable5
    fi
    if [ $variable1 == "put" ] && [ `grep -wc "$variable2 .*" $variable5` -eq 1 ] && [ ! -f ${variable2} ] && [ ! -f ${variable3} ];  
    then sed -ie  "s/$variable2 .*/$variable2 $variable3/g" $variable5
	rm ""$variable5"e"
    fi
fi

#Si -f est precede de del ou select(avec keys)
if [ $variable3 == "-f" ] && [ $variable1 == "del" ] || [ $variable3 == "-f" ] && [ $variable1 == "select"] && [ ! -f ${variable2} ];
then touch $variable4
    if [ $variable1 == "del" ];
    then sed -ie "s/$variable2.*/$variable2/g" $variable4 
	rm ""$variable4"e"
    fi
    if [ $variable1 == "select" ] && [ ! -f ${variable2} ];
    then grep "$variable2 *." $variable4 | cut -d ' ' -f 2 
    fi
fi

#Si -f est precede de select sans rien
if [ $variable2 == "-f" ] && [ $variable1 == "select" ]
then touch $variable3
  if [ $variable1 == "select" ]
  then  cut -d " " -f 2 $variable3
  fi
fi





