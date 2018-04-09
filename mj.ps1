# Josh Jenkins
# created in 2018
# mouse jiggler cause skype sucks
# Creates a background process that can only be ended with "Task Manager"

cls

# .Net methods for hiding/showing the console in the background
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
function Hide-Console
{
    $consolePtr = [Console.Window]::GetConsoleWindow()
    #0 hide
    [Console.Window]::ShowWindow($consolePtr, 0)
}
Hide-Console

cls

# How many seconds between jiggles
$seconds=7

# Pixels to jiggle
$pixels=1

# Add the .NET class
Add-Type -AssemblyName System.Windows.Forms

# Loop forever
while ($true) {
  # Get the current mouse position
  $Pos = [System.Windows.Forms.Cursor]::Position
  # Move the mouse a distance to the right, then wait
  [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point((($Pos.X) + $pixels) , $Pos.Y)
  Start-Sleep -Seconds $seconds

  # Get the current mouse position
  $Pos = [System.Windows.Forms.Cursor]::Position
  # Move the mouse a distance to the left, then wait
  [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point((($Pos.X) - $pixels) , $Pos.Y)
  Start-Sleep -Seconds $seconds
}
