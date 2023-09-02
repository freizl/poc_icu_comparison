#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unicode/ucol.h>
#include <unicode/ustring.h>

int main() {
  UErrorCode status = U_ZERO_ERROR;
  UCollator *collator = ucol_open("", &status);

  if (U_FAILURE(status)) {
    fprintf(stderr, "Error opening collator: %s\n", u_errorName(status));
    exit(EXIT_FAILURE);
  }

  const char *str1 = "locked_by";
  const char *str2 = "lock_note";
  /* const char *str1 = "id"; */
  /* const char *str2 = "created_at"; */

  size_t length1 = strlen(str1);
  size_t length2 = strlen(str2);

  UCollationResult result =
      ucol_strcollUTF8(collator, str1, length1, str2, length2, &status);

  if (U_FAILURE(status)) {
    fprintf(stderr, "Error comparing strings: %s\n", u_errorName(status));
    ucol_close(collator);
    exit(EXIT_FAILURE);
  }

  printf("%s, %s, %d\n", str1, str2, result);
  if (result == UCOL_LESS) {
    printf("'%s' is less than '%s'\n", str1, str2);
  } else if (result == UCOL_GREATER) {
    printf("'%s' is greater than '%s'\n", str1, str2);
  } else {
    printf("'%s' is equal to '%s'\n", str1, str2);
  }

  ucol_close(collator);
  return 0;
}

/* int main3() { */
/*   UErrorCode status = U_ZERO_ERROR; */
/*   UCollator *collator = ucol_open("", &status); */

/*   if (U_FAILURE(status)) { */
/*     fprintf(stderr, "Error opening collator: %s\n", u_errorName(status)); */
/*     return 1; */
/*   } */

/*   const UChar *str1 = u"locked_by"; */
/*   const UChar *str2 = u"lock_note"; */

/*   int32_t result = ucol_strcoll(collator, str1, -1, str2, -1); */

/*   if (U_FAILURE(status)) { */
/*     fprintf(stderr, "Error comparing strings: %s\n", u_errorName(status)); */
/*     ucol_close(collator); */
/*     return 1; */
/*   } */

/*   printf("%s, %s, %d", str1, str2, result); */

/*   ucol_close(collator); */
/*   return 0; */
/* } */
