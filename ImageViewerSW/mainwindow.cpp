#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "imagealbum.h"

#include <QFileDialog>
#include <QColorSpace>
#include <QMessageBox>
#include <QImageReader>
#include <QMdiSubWindow>
#include <QVBoxLayout>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    m_imageAlbum = new ImageAlbum(this);

    QVBoxLayout *AlbumLayout = new QVBoxLayout();
    AlbumLayout->addWidget(m_imageAlbum);

    ui->frame->setLayout(AlbumLayout);

}

MainWindow::~MainWindow()
{
    delete ui;
}


