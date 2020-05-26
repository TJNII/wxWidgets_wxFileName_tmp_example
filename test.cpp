#include<iostream>
#include <wx/filename.h>

using namespace std;

int main()
{
  char *test_paths[3] = {"/tmp", "/tmp/", "/tmp/subdir"};
  int count;

  for(count = 0; count < 3; count += 1) {
    cout << "Target path " << test_paths[count] << ":\n";

    wxFileName tmpPath(test_paths[count]);

    cout << "\tExists: ";
    if(tmpPath.Exists())
      cout << "True";
    else
      cout << "False";

    cout << "\n\tIsDirWritable: ";
    if(tmpPath.IsDirWritable())
      cout << "True";
    else
      cout << "False";

    cout << "\n\n";
  }

  return 0;
}
