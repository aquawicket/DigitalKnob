// Ensure the System.Windows.Forms namespace is included (and referenced in your project)
using System.Windows.Forms;
using System.IO; // Required for file operations

// ... inside a method, e.g., a button click event handler ...
private void buttonOpenFile_Click(object sender, EventArgs e)
{
    OpenFileDialog openFileDialog1 = new OpenFileDialog();

    // Set properties
    openFileDialog1.InitialDirectory = @"C:\";
    openFileDialog1.Title = "Browse Text Files";
    openFileDialog1.CheckFileExists = true;
    openFileDialog1.CheckPathExists = true;
    openFileDialog1.DefaultExt = "txt";
    openFileDialog1.Filter = "Text files (*.txt)|*.txt|All files (*.*)|*.*";
    openFileDialog1.FilterIndex = 1;
    openFileDialog1.RestoreDirectory = true;

    // Show the dialog and check for a positive result
    if (openFileDialog1.ShowDialog() == DialogResult.OK)
    {
        // Get the path of the selected file
        string filePath = openFileDialog1.FileName;
        
        // Example of reading the file content into a TextBox
        // You would need a TextBox control named 'textBoxFileContent'
        try
        {
            // Read the entire file as text
            string fileContent = File.ReadAllText(filePath);
            // textBoxFileContent.Text = fileContent; 
        }
        catch (Exception ex)
        {
            MessageBox.Show("Error: Could not read file from disk. Original error: " + ex.Message);
        }
    }
}
