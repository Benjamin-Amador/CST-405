#include <vector>
#include <string>
#include <iostream>
#include <fstream>

using namespace std;

bool isDeadCodeRemoved = false;

vector<string> split(string s, string delimiter)
{
    size_t pos_start = 0, pos_end, delim_len = delimiter.length();
    string token;
    vector<std::string> res;

    while ((pos_end = s.find(delimiter, pos_start)) != string::npos) {
        token = s.substr(pos_start, pos_end - pos_start);
        pos_start = pos_end + delim_len;
        res.push_back(token);
    }

    res.push_back(s.substr(pos_start));
    return res;
}

void OptimizatingCode()
{
    fstream newfile;
    newfile.open("outputFile.txt"); //Change the file name here to match your output.
    ofstream outputFile("outputFileC.txt");


    string inputData[142][3];
    int depthCounter = 0;
    int colnum = 0; // column number of the array
    int rownum = 0; // row number of the array

    if (newfile.is_open())
    {
        rownum = 0;
        string str;
        // read file
        while (getline(newfile, str))
        {
            // parse columns
            string delimiter = " | ";
            vector<string> v = split(str, delimiter);

            // populate astr array
            for (auto i : v)
            {
                inputData[rownum][colnum] = i;
                colnum++;
            }
            rownum++;
            colnum = 0;
        }
    }
    rownum = sizeof(inputData) / sizeof(inputData[0]);

    cout << rownum;

    ////////Edit from here /////////
    bool isReachable = true;
    string stringLineNumber;
    int lineNumberToKeepTrackOf = INT8_MAX;
    int bracketCounter = 0;
    int lineNumber;
    for (int i = 0; i < rownum; i++)
    {

        if (inputData[i][0] == "return" || inputData[i][0] == "break" || inputData[i][0] == "continue")
        {
            lineNumberToKeepTrackOf = stoi(inputData[i][2], nullptr, 10);
        }
        stringLineNumber = inputData[i][2];
        //cout << stringLineNumber << endl;
        lineNumber = stoi(stringLineNumber, nullptr, 10);
        if (lineNumber > lineNumberToKeepTrackOf)
        {
            isReachable = false;
            if (inputData[i][0] == "{")
            {
                bracketCounter++;
            }
            else if (inputData[i][0] == "}" && bracketCounter != 0)
            {
                bracketCounter--;
            }
            else if (inputData[i][0] == "}" && bracketCounter == 0)
            {
                isReachable = true;
                lineNumberToKeepTrackOf = INT8_MAX;
            }
        }
        if (isReachable)
        {
            //print
            outputFile << inputData[i][0] + " | " + inputData[i][1] + " | " + inputData[i][2] + "\n";
        }
    }
}

void eliminatingDeadCode()
{
    fstream newfile;
    newfile.open("outputFileC.txt"); //Change the file name here to match your output.
    fstream outputFile;
    outputFile.open("outputFileC.txt");
    string tempString;


    string inputData[142][3];
    int depthCounter = 0;
    int colnum = 0; // column number of the array
    int rownum = 0; // row number of the array
    int tempLineNum;

    if (newfile.is_open())
    {
        rownum = 0;
        string str;
        // read file
        while (getline(newfile, str))
        {
            // parse columns
            string delimiter = " | ";
            vector<string> v = split(str, delimiter);

            // populate astr array
            for (auto i : v)
            {
                inputData[rownum][colnum] = i;
                colnum++;
            }
            rownum++;
            colnum = 0;
        }
    }
    rownum = sizeof(inputData) / sizeof(inputData[0]);

    ////Unique code begins here//////
    string livingVariables[15];
    string extraTemp;
    int livingVariablesCounter = 0;
    int lineNumberToKeepTrackOf = INT8_MAX;
    for (int i = 0; i < rownum; i++)
    {
        if (inputData[i][0] != "")
        {
            tempString = inputData[i][2];
            tempLineNum = stoi(tempString, nullptr, 10);
            if (inputData[i][0] == "return" || inputData[i][0] == "write")
            {
                lineNumberToKeepTrackOf = tempLineNum;
            }

            if (tempLineNum == lineNumberToKeepTrackOf)
            {
                if (inputData[i][1] == "ID")
                {
                    bool unique = true;
                    for (int j = 0; j <= livingVariablesCounter; j++)
                    {
                        if (livingVariables[livingVariablesCounter] == inputData[i][0])
                        {
                            unique = false;
                        }
                    }

                    if (unique)
                    {
                        livingVariables[livingVariablesCounter] = inputData[i][0];
                    }
                }
            }
        }
    }
    int passCounter = 0;
    for (int j = 0; j <= livingVariablesCounter; j++)
    {
        passCounter++;
        cout << "       j loop          " << passCounter << endl;
        lineNumberToKeepTrackOf = INT8_MAX;
        for (int i = 0; i < rownum; i++)
        {
            cout << "i loop " << i << endl;
            if (inputData[i][0] != "")
            {
                tempString = inputData[i][2];

                tempLineNum = stoi(tempString, nullptr, 10);
                bool startOfLine;

                if (i > 0)
                {
                    extraTemp = inputData[i - 1][2];
                    if (tempString == extraTemp)
                    {
                        startOfLine = false;
                    }
                    else
                    {
                        startOfLine = true;
                    }
                }
                else
                {
                    startOfLine = true;
                }
                if (inputData[i][0] == livingVariables[j] && startOfLine)
                {
                    lineNumberToKeepTrackOf = tempLineNum;
                }
                else if (tempLineNum == lineNumberToKeepTrackOf && inputData[i][1] == "ID")
                {
                    bool unique = true;
                    for (int k = 0; k <= livingVariablesCounter; k++)
                    {
                        if (livingVariables[livingVariablesCounter] == inputData[i][0])
                        {
                            unique = false;
                        }
                    }

                    if (unique)
                    {
                        livingVariablesCounter++;
                        livingVariables[livingVariablesCounter] = inputData[i][0];
                    }
                }
            }
        }
    }
    lineNumberToKeepTrackOf = INT8_MAX;
    int lineStart = INT8_MAX;
    for (int i = 0; i < rownum; i++)
    {
        if (inputData[i][0] != "")
        {
            //Eliminate code containing variables not contained in the livingVariables array
            if (inputData[i][0] != "NAH")
            {
                tempString = inputData[i][2];
                extraTemp = inputData[i - 1][2];
                tempLineNum = stoi(tempString, nullptr, 10);
                if (i > 0)
                {
                    if (tempString != extraTemp)
                    {
                        lineStart = i;
                    }
                }
                else
                {
                    lineStart = 0;
                }
                if (inputData[i][1] == "ID")
                {
                    lineNumberToKeepTrackOf = tempLineNum;
                    inputData[i][0] = "NAH";
                    i = lineStart;
                }
                if (tempLineNum == lineNumberToKeepTrackOf)
                {
                    inputData[i][0] = "NAH";
                }
            }
        }
    }
    for (int i = 0; i < rownum; i++)
    {
        if (inputData[i][0] != "NAH")
        {
            outputFile << inputData[i][0] + " | " + inputData[i][1] + " | " + inputData[i][2] + "\n";
        }
    }
}

int main()
{
    OptimizatingCode();
    //eliminatingDeadCode();
}