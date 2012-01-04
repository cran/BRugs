AC_INIT([BRugs], [0.7])

## Work around the inconsistency between the installation destinations of the 3.2.1 source and binary packages. 
## Source installs library in $prefix/lib/OpenBUGS/lib, doc in $prefix/lib/OpenBUGS/doc. 
## Binaries install in standards-compliant locations $prefix/lib and $prefix/share/doc/openbugs-version respectively. 
## Look in all of these places. 
## Return OPENBUGS = $prefix/lib/OpenBUGS for source installations, and
##  OPENBUGS = $prefix for binary installations.
## Return OPENBUGSDOC = $prefix/lib/OpenBUGS/doc for source installations, 
##  and OPENBUGSDOC = $prefix/share/doc/openbugs-version for binary installations. 
## If user specifies -with-openbugs, this is interpreted for a source installation. 

## TODO only runs on x86 Linux - give error on other unixes.  

AC_PREFIX_DEFAULT(/usr/local)
AC_PREFIX_PROGRAM([OpenBUGS])

AC_ARG_WITH([openbugs],
	AC_HELP_STRING([--with-openbugs=PATH],
			[the location of OpenBUGS installed from the source package, by default /usr/local/lib/OpenBUGS]),
            [openbugs_path=$withval])

if test [ -n "$openbugs_path" ] ; then
   OPENBUGS=${openbugs_path}
   SOURCEINST=true
else
   if test [ "$prefix" = "NONE" ]; then 
      AC_MSG_ERROR( [OpenBUGS not found. Install OpenBUGS 3.2.1 or later, or specify its location using, for example, R CMD INSTALL BRugs --configure-args='--with-openbugs=/usr/local/lib/OpenBUGS'] )
   else
      if test [ -e ${prefix}/lib/OpenBUGS/lib/libOpenBUGS.so ] ; then
            OPENBUGS=${prefix}/lib/OpenBUGS
	    SOURCEINST=true
      else
            OPENBUGS=${prefix}
            SOURCEINST=false
      fi
   fi
fi

OLDFLAGS=${LDFLAGS}
LDFLAGS="-L${OPENBUGS}/lib -m32"
AC_CHECK_LIB(OpenBUGS, CmdInterpreter, [],
             [AC_MSG_ERROR("Cannot load OpenBUGS library in ${OPENBUGS}/lib. Run R CMD INSTALL BRugs --configure-args='--with-openbugs=...'")])
LDFLAGS=${OLDFLAGS}

VERSION=`echo "modelQuit()" | ${OPENBUGS}/bin/OpenBUGS | sed -ne "s/OpenBUGS version \(.*\) rev \(.*\)/\1/p"`
if test [`echo ${VERSION} |cut -d. -f1` -lt 3]; then
 AC_MSG_ERROR([Requires OpenBUGS version 3.2.1 or greater])
fi
if test [ `echo ${VERSION} |cut -d. -f1` -eq 3  -a  `echo ${VERSION} |cut -d. -f2` -lt 2 ]; then
 AC_MSG_ERROR([Requires OpenBUGS version 3.2.1 or greater])
fi

if [ ${SOURCEINST} ] ; then 
   AC_MSG_NOTICE( [Found OpenBUGS installation from source package] )
   OPENBUGSDOC=${OPENBUGS}/doc
else
   AC_MSG_NOTICE( [Found OpenBUGS installation from binary package] )
   OPENBUGSDOC=${OPENBUGS}/share/doc/openbugs-${VERSION}
fi

OPENBUGS=${OPENBUGS}/lib
DYNLIBEXT="so"

AC_SUBST(OPENBUGS)
AC_SUBST(OPENBUGSDOC)
AC_SUBST(DYNLIBEXT)
AC_OUTPUT(src/Makevars)
AC_OUTPUT(R/unix/zzz.R)
