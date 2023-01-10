#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QLabel>
#include <QScrollArea>
#include <QWheelEvent>
#include <QGraphicsView>
#include <QObject>
#include <QListWidgetItem>
#include "imagealbum.h"

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class EditImage;
class ImageAlbum;

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private:
    Ui::MainWindow *ui;
    QImage *img;
    ImageAlbum* m_imageAlbum;


};
#endif // MAINWINDOW_H
