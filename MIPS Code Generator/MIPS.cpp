#include <vector>
#include <string>
#include <iostream>
#include <fstream>

using namespace std;

vector<string> split(string s, string delimiter)
{
    size_t pos_start = 0, pos_end, delim_len = delimiter.length();
    string token;
    vector<std::string> res;

    while ((pos_end = s.find(delimiter, pos_start)) != string::npos)
    {
        token = s.substr(pos_start, pos_end - pos_start);
        pos_start = pos_end + delim_len;
        res.push_back(token);
    }

    res.push_back(s.substr(pos_start));
    return res;
}

void MIPS()
{
    fstream newfile;
    newfile.open("OutputFile.txt"); // Change the file name here to match your output.
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


    ////////Edit from here /////////
    string rowToKeepTrackOf = "";
    string ex, exp, exp1 = "";
    bool lastOfRow = false;
    int numberOfTermsInRow = 0;
    int variableCounter = 0;
    int importantIValues[15];
    int properValue = 0;
    for (int i = 0; i < rownum; i++)
    {
        if (inputData[i][0] != "")
        {
            if (i == 0)
            {
                rowToKeepTrackOf = "1";
                lastOfRow = false;
                numberOfTermsInRow = 0;
            }
            else if (inputData[i][2] != inputData[i - 1][2])
            {
                rowToKeepTrackOf = inputData[i][2];
                lastOfRow = false;
                numberOfTermsInRow = 0;
            }
            else if (inputData[i][2] != inputData[i + 1][2])
            {
                lastOfRow = true;
                numberOfTermsInRow++;
            }
            else if (inputData[i][2] == rowToKeepTrackOf)
            {
                lastOfRow = false;
                numberOfTermsInRow++;
            }
            ex = "";

            if (lastOfRow)
            {
                // Variable Declaration
                if (inputData[i - numberOfTermsInRow][1] == "Type"
                    && inputData[i - (numberOfTermsInRow - 1)][1] == "ID"
                    && inputData[i - (numberOfTermsInRow - 2)][1] != "bracket")
                {
                    importantIValues[variableCounter] = i - (numberOfTermsInRow - 1);
                    if (inputData[i - (numberOfTermsInRow - 2)][0] == "="
                        && inputData[i - (numberOfTermsInRow - 3)][1] == "NUM")
                    {
                        if (inputData[i - (numberOfTermsInRow - 4)][1] == "break")
                        {
                            outputFile << "li $t";
                            outputFile << variableCounter;
                            outputFile << ", ";
                            outputFile << inputData[i - (numberOfTermsInRow - 3)][0];
                            outputFile << "\n";
                        }
                        else if (inputData[i - (numberOfTermsInRow - 4)][1] == "operator")
                        {
                            outputFile << "li $t";
                            outputFile << variableCounter;
                            outputFile << ", ";
                            outputFile << inputData[i - (numberOfTermsInRow - 3)][0];
                            outputFile << "\n";

                            for (int j = 4; j <= numberOfTermsInRow; j++)
                            {
                                if (inputData[i - (numberOfTermsInRow - (j + 1))][1] == "NUM")
                                {
                                    if (inputData[i - (numberOfTermsInRow - j)][0] == "+")
                                    {
                                        outputFile << "add $t";
                                        outputFile << variableCounter;
                                        outputFile << ", $t";
                                        outputFile << variableCounter;
                                        outputFile << ", ";
                                        outputFile
                                            << inputData[i - (numberOfTermsInRow - (j + 1))][0];
                                        outputFile << "\n";
                                    }
                                    else if (inputData[i - (numberOfTermsInRow - j)][0] == "-")
                                    {
                                        outputFile << "sub $t";
                                        outputFile << variableCounter;
                                        outputFile << ", $t";
                                        outputFile << variableCounter;
                                        outputFile << ", ";
                                        outputFile
                                            << inputData[i - (numberOfTermsInRow - (j + 1))][0];
                                        outputFile << "\n";
                                    }
                                    else if (inputData[i - (numberOfTermsInRow - j)][0] == "*")
                                    {
                                        outputFile << "mul $t";
                                        outputFile << variableCounter;
                                        outputFile << ", ";
                                        outputFile
                                            << inputData[i - (numberOfTermsInRow - (j + 1))][0];
                                        outputFile << ", $t";
                                        outputFile << variableCounter;
                                        outputFile << "\n";
                                    }
                                    else if (inputData[i - (numberOfTermsInRow - j)][0] == "/")
                                    {
                                        outputFile << "div $t";
                                        outputFile << variableCounter;
                                        outputFile << ", ";
                                        outputFile
                                            << inputData[i - (numberOfTermsInRow - (j + 1))][0];
                                        outputFile << "\n";
                                        outputFile << "mflo $t";
                                        outputFile << variableCounter;
                                        outputFile << "\n";
                                    }
                                }
                                else if (inputData[i - (numberOfTermsInRow - (j + 1))][1] == "ID")
                                {
                                    bool existingVariable = false;
                                    for (int k = 0; k <= variableCounter; k++)
                                    {
                                        if (inputData[i - numberOfTermsInRow][0]
                                            == inputData[importantIValues[k]][0])
                                        {
                                            existingVariable = true;
                                            properValue = k;
                                        }
                                        if (inputData[i - (numberOfTermsInRow - j)][0] == "+")
                                        {
                                            outputFile << "add $t";
                                            outputFile << variableCounter;
                                            outputFile << ", $t";
                                            outputFile << variableCounter;
                                            outputFile << ", $t";
                                            outputFile << properValue;
                                            outputFile << "\n";
                                        }
                                        else if (inputData[i - (numberOfTermsInRow - j)][0] == "-")
                                        {
                                            outputFile << "sub $t";
                                            outputFile << variableCounter;
                                            outputFile << ", $t";
                                            outputFile << variableCounter;
                                            outputFile << ", $t";
                                            outputFile << properValue;
                                            outputFile << "\n";
                                        }
                                        else if (inputData[i - (numberOfTermsInRow - j)][0] == "*")
                                        {
                                            outputFile << "mul $t";
                                            outputFile << variableCounter;
                                            outputFile << ", $t";
                                            outputFile << variableCounter;
                                            outputFile << ", $t";
                                            outputFile << properValue;
                                            outputFile << "\n";
                                        }
                                        else if (inputData[i - (numberOfTermsInRow - j)][0] == "/")
                                        {
                                            outputFile << "div $t";
                                            outputFile << variableCounter;
                                            outputFile << ", $t";
                                            outputFile << properValue;
                                            outputFile << "\n";
                                            outputFile << "mflo $t";
                                            outputFile << variableCounter;
                                            outputFile << "\n";
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                else if (inputData[i - numberOfTermsInRow][1] == "Type"
                    && inputData[i - (numberOfTermsInRow - 1)][1] == "ID"
                    && inputData[i - (numberOfTermsInRow - 2)][1] == "break")
                {
                    outputFile << "li $t";
                    outputFile << variableCounter;
                    outputFile << ", 0\n";
                    variableCounter++;
                }

                // Math
                else if (inputData[i - numberOfTermsInRow][1] == "ID")
                {
                    bool existingVariable = false;
                    for (int j = 0; j <= variableCounter; j++)
                    {
                        if (inputData[i - numberOfTermsInRow][0]
                            == inputData[importantIValues[j]][0])
                        {
                            existingVariable = true;
                            properValue = j;
                        }
                    }
                    for (int j = 4; j <= numberOfTermsInRow; j++)
                    {
                        if (inputData[i - (numberOfTermsInRow - (j + 1))][1] == "NUM")
                        {
                            if (inputData[i - (numberOfTermsInRow - j)][0] == "+")
                            {
                                outputFile << "add $t";
                                outputFile << properValue;
                                outputFile << ", $t";
                                outputFile << properValue;
                                outputFile << ", ";
                                outputFile << inputData[i - (numberOfTermsInRow - (j + 1))][0];
                                outputFile << "\n";
                            }
                            else if (inputData[i - (numberOfTermsInRow - j)][0] == "-")
                            {
                                outputFile << "sub $t";
                                outputFile << properValue;
                                outputFile << ", $t";
                                outputFile << properValue;
                                outputFile << ", ";
                                outputFile << inputData[i - (numberOfTermsInRow - (j + 1))][0];
                                outputFile << "\n";
                            }
                            else if (inputData[i - (numberOfTermsInRow - j)][0] == "*")
                            {
                                outputFile << "mul $t";
                                outputFile << properValue;
                                outputFile << ", $t";
                                outputFile << properValue;
                                outputFile << ", ";
                                outputFile << inputData[i - (numberOfTermsInRow - (j + 1))][0];
                                outputFile << "\n";
                            }
                            else if (inputData[i - (numberOfTermsInRow - j)][0] == "/")
                            {
                                outputFile << "div $t";
                                outputFile << properValue;
                                outputFile << ", ";
                                outputFile << inputData[i - (numberOfTermsInRow - (j + 1))][0];
                                outputFile << "\n";
                                outputFile << "mflo $t";
                                outputFile << properValue;
                                outputFile << "\n";
                            }
                        }
                        else if (inputData[i - (numberOfTermsInRow - (j + 1))][1] == "ID")
                        {
                            bool existingVariable = false;
                            int otherValue;
                            for (int k = 0; k <= variableCounter; k++)
                            {
                                if (inputData[i - numberOfTermsInRow][0]
                                    == inputData[importantIValues[k]][0])
                                {
                                    existingVariable = true;
                                    otherValue = k;
                                }
                                if (inputData[i - (numberOfTermsInRow - j)][0] == "+")
                                {
                                    outputFile << "add $t";
                                    outputFile << properValue;
                                    outputFile << ", $t";
                                    outputFile << properValue;
                                    outputFile << ", $t";
                                    outputFile << otherValue;
                                    outputFile << "\n";
                                }
                                else if (inputData[i - (numberOfTermsInRow - j)][0] == "-")
                                {
                                    outputFile << "sub $t";
                                    outputFile << properValue;
                                    outputFile << ", $t";
                                    outputFile << properValue;
                                    outputFile << ", $t";
                                    outputFile << otherValue;
                                    outputFile << "\n";
                                }
                                else if (inputData[i - (numberOfTermsInRow - j)][0] == "*")
                                {
                                    outputFile << "mul $t";
                                    outputFile << properValue;
                                    outputFile << ", $t";
                                    outputFile << properValue;
                                    outputFile << ", $t";
                                    outputFile << otherValue;
                                    outputFile << "\n";
                                }
                                else if (inputData[i - (numberOfTermsInRow - j)][0] == "/")
                                {
                                    outputFile << "div $t";
                                    outputFile << variableCounter;
                                    outputFile << ", $t";
                                    outputFile << otherValue;
                                    outputFile << "\n";
                                    outputFile << "mflo $t";
                                    outputFile << variableCounter;
                                    outputFile << "\n";
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

int main()
{
    MIPS();
}