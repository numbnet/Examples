Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Data Entry Form'
$form.Size = New-Object System.Drawing.Size(300,250)     ## шир вис
$form.StartPosition = 'CenterScreen'

##********************************************
##Укажите размер и поведение кнопки ОК.
##кнопка расположена на 120 пикселей ниже верхней границы формы и на 75 пикселей правее левой границы.
## Высота кнопки — 23 пикселя, а длина — 75 пикселей
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(75,120)   ##  розмер Кнопки  левая
$OKButton.Size = New-Object System.Drawing.Size(75,23)        ##  позиция Кнопки левая
$OKButton.Text = 'OK'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

##********************************************
## кнопку Отмена.
## Кнопка Отмена расположена на 120 пикселей ниже верхней границы 
## на 150 пикселей правее левой границы окна.
$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(150,120)     ##  розмер Кнопки  правая
$CancelButton.Size = New-Object System.Drawing.Size(75,23)            ##  позиция Кнопки  правая
$CancelButton.Text = 'Cancel'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)


##********************************************
## Далее введите текст метки в окне, который должны получить пользователи.
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)       ## сдвиг верхнего текста
$label.Size = New-Object System.Drawing.Size(280,20)       ##
$label.Text = 'Сделайте выбор:'
$form.Controls.Add($label)


##********************************************
##Добавьте элемент управления (в данном случае список),
## который позволит пользователям указать сведения, описанные в тексте метки
$listBox = New-Object System.Windows.Forms.Listbox
$listBox.Location = New-Object System.Drawing.Point(10,40)       ## сдвиг окна выбора вверх и в право
$listBox.Size = New-Object System.Drawing.Size(260,250)       ## сдвиг в лево и 


##********************************************
##
$listBox.SelectionMode = 'MultiExtended'


##********************************************
##
[void] $listBox.Items.Add('Item 1')
[void] $listBox.Items.Add('Item 2')
[void] $listBox.Items.Add('Item 3')
[void] $listBox.Items.Add('Item 4')
[void] $listBox.Items.Add('Item 5')
[void] $listBox.Items.Add('Item 6')
[void] $listBox.Items.Add('Item 7')
[void] $listBox.Items.Add('Item 8')
[void] $listBox.Items.Add('Item 9')


##********************************************
## 
$listBox.Height = 70                      ## Высота внутри окна выбора
$form.Controls.Add($listBox)              ##   открывался в Windows поверх других диалоговых окон.
$form.Topmost = $true

$result = $form.ShowDialog()            ##  для отображения формы в Windows.



##********************************************
## внутри блока If указывает Windows, что следует делать с формой после того,
##  как пользователь выберет параметр из списка и нажмет кнопку ОК или клавишу ВВОД.
if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $x = $listBox.SelectedItems
    $x
}


