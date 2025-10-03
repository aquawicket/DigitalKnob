using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;
using System.IO;
using Microsoft.Win32;

namespace GetSvcHostServices
{
    class Program
    {
        static void Main(string[] args)
        {
            using (StreamWriter sw = new StreamWriter("out.html", false))
            {
                sw.WriteLine("<table><tr><th>Group</th><th>Description</th>\n<th>SvcHost Command</th>\n<th>Full Path</th></tr>");

                RegistryKey servicesKey = Registry.LocalMachine.OpenSubKey(@"SYSTEM\CurrentControlSet\Services", true);
                string[] servicesNames = servicesKey.GetSubKeyNames();

                foreach (string serviceName in servicesNames)
                {
                    RegistryKey oneServiceKey = Registry.LocalMachine.OpenSubKey(@"SYSTEM\CurrentControlSet\Services\" + serviceName, false);
                    if (oneServiceKey.GetValue("ImagePath") != null)
                    {
                        string imagePath = oneServiceKey.GetValue("ImagePath").ToString();
                        if (imagePath.Contains("svchost.exe -k"))
                        {
                            string displayName = oneServiceKey.GetValue("DisplayName").ToString();
                            string fileName = displayName.Substring(1, displayName.IndexOf(",") - 1).ToLower();
                            
                            fileName = Environment.ExpandEnvironmentVariables(fileName).ToLower();
                            
                            if (!fileName.StartsWith("c:"))
                            {
                                fileName = "c:\\windows\\system32\\" + fileName;
                            }

                            string group = imagePath.Substring(imagePath.IndexOf("-k") + 3);

                            FileVersionInfo fvi = FileVersionInfo.GetVersionInfo(fileName);
                            string output = string.Format("<tr><td>{0}</td>\n<td>{1}</td>\n<td>{2}</td><td>{3}</td></tr>", group, fvi.FileDescription, fileName, imagePath);
                            sw.WriteLine(output);
                        }
                    }
                    oneServiceKey.Close();
                }
                sw.WriteLine("</table>");
                sw.Close();
            }
        }
    }
}