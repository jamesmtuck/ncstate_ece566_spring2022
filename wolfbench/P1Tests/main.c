#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int func_to_call(int, int*);

#ifndef WEIGHT
int weight = 1;
#else
int weight = WEIGHT;
#endif

int main(int argc, char ** argv)
{
  if (argc < 2)
    {
      printf("Error, not enough arguments to program.\n");
      return 1;
    }

  FILE *fin = fopen(argv[1],"r");
  int len;
  int *input = NULL;
  int *output = NULL;
  int ret_value;

  if ( 0 == fscanf(fin, "%d", &len) )
    {
      printf("Error. Expected integer at beginning of file.\n");
      return 1;
    }

  if (len>0)
    {      
      input = malloc(sizeof(int)*len*3);  // pad the array
      output = malloc(sizeof(int)*len*3);

      input += len;  // put pointer in middle of padding
      output += len;
      
      for(int i=0; i<len; i++)
	if( 0 == fscanf(fin, "%d", &input[i]) )
	  {
	    printf("Error. File format incorrect. Expected integer.\n");
	    return 1;
	  }
    }
  else
    {
      input = malloc(sizeof(int)*10);
      output = malloc(sizeof(int)*10);
    }
  
  if ( 0 == fscanf(fin, "%d", &ret_value) )
    {
      printf("Error. Expected integer at beginning of file.\n");
      return 1;
    }

  if (len>0)
    {
      for(int i=0; i<len; i++)
	if( 0 == fscanf(fin, "%d", &output[i]) )
	  {
	    printf("Error. File format incorrect. Expected integer.\n");
	    return 1;
	  }
    }

  if ( 0 == fscanf(fin, "%d", &weight) )
    {
      // no weight specified
    }
  
  fclose(fin);

  int got_ret = func_to_call(len, input);
  int errors = 0;
  int success=0;
  
  if (ret_value != got_ret)
    {
      fprintf(stderr,"Return value is incorrect. Expected %d but got %d.\n",ret_value,got_ret);
      errors ++;

    }
  else
    success ++;

  for (int i=0; i<len; i++)
    {
      if (input[i] != output[i])
	{
	  fprintf(stderr,"arg_array[%d] incorrect. Expected %d but got %d.\n",
		  i,output[i],input[i]);
	  errors ++;
	}
      else
	{
	  success ++;
	}
    }

  int total=success+errors;
  //printf("success,%d\nerrors,%d\ntotal,%d\n",success*10/total,errors*10/total,total*10/total);
  printf("success,%d\nerrors,%d\ntotal,%d\n",success*weight/total,errors*weight/total,total*weight/total);

  return 0;
}
