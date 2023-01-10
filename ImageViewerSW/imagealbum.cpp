#include <QSplitter>
#include <QListWidget>
#include <QDir>
#include <QFileInfo>
#include <QGraphicsScene>
#include <QGroupBox>
#include <QColorDialog>
#include <QMouseEvent>

#include "imagealbum.h"
#include "ui_imagealbum.h"
#include "imageview.h"

#define LIMIT_UBYTE(n) (n > UCHAR_MAX) ? UCHAR_MAX:(n<0) ? 0 : n

ImageAlbum::ImageAlbum(QWidget *parent)
    : QWidget(parent), ui(new Ui::ImageAlbum)
{
    ui->setupUi(this);
    imageView = new ImageView();

//    imageView->setHorizontalScrollBarPolicy(Qt::ScrollBarAlwaysOn);
//    imageView->setVerticalScrollBarPolicy(Qt::ScrollBarAlwaysOn);
//    imageView->setScene(imageView->graphicsScene);
//    imageView->graphicsScene->setSceneRect(0, 0,
//    imageView->graphicsScene->width(), imageView->graphicsScene->height());
//    imageView->grabGesture(Qt::PinchGesture);

//    listWidget = new QListWidget(this);
//    listWidget->setIconSize(QSize(120, 80));
//    listWidget->setVerticalScrollBarPolicy(Qt::ScrollBarAlwaysOff);

    connect(ui->listWidget, SIGNAL(itemDoubleClicked(QListWidgetItem*)), SLOT(selectItem(QListWidgetItem*)));
    ui->graphicsView->setScene(imageView->graphicsScene);

//    setOrientation(Qt::Horizontal);
//    addWidget(listWidget);
//    addWidget(imageView);
//    setStretchFactor(0, 3);

//    QList<int> list;
//    list << 520 << 100;
//    setSizes(list);


    connect(ui->ZoomIn, SIGNAL(clicked()), this, SLOT(ZoomIn()));
    connect(ui->ZoomOut, SIGNAL(clicked()), this, SLOT(ZoomOut()));
    connect(ui->LeftRotate, SIGNAL(clicked()), this, SLOT(LeftRotate()));
    connect(ui->RightRotate, SIGNAL(clicked()), this, SLOT(RightRotate()));
    connect(ui->Brush, SIGNAL(clicked()), this, SLOT(Brush()));
    connect(ui->OrigImage, SIGNAL(clicked()), this, SLOT(OrigImage()));
    connect(ui->horizontalSlider, SIGNAL(sliderMoved(int)), this, SLOT(Brightness(int)));
    connect(ui->Gamma, SIGNAL(clicked()), this, SLOT(Gamma()));
    connect(ui->Sobel, SIGNAL(clicked()), this, SLOT(Sobel()));
    connect(ui->VReverse, SIGNAL(clicked()), this, SLOT(VReverse()));
    connect(ui->HReverse, SIGNAL(clicked()), this, SLOT(HReverse()));


    reloadImages();
}

ImageAlbum::~ImageAlbum()
{

}

void ImageAlbum::reloadImages()
{
    QDir dir(".");
    QStringList filters;
    filters << "*.png" << "*.jpg" << "*.bmp";
    QFileInfoList fileInfoList = dir.entryInfoList(filters, QDir::Files | QDir::NoDotAndDotDot);
    imageView->graphicsScene->clear();

    ui->listWidget->clear();
    for(int i = 0; i < fileInfoList.count(); i++) {
        QListWidgetItem* item = new QListWidgetItem(QIcon(fileInfoList.at(i).fileName()), NULL, ui->listWidget); //, QListWidgetItem::UserType);
        item->setStatusTip(fileInfoList.at(i).fileName());
        ui->listWidget->addItem(item);
    };
}

void ImageAlbum::Brush()
{
    ui->graphicsView->setDragMode(QGraphicsView::NoDrag);
    paintColor = QColorDialog::getColor(paintColor, this);

}

void ImageAlbum::ZoomIn()
{
    ui->graphicsView->scale(1.2, 1.2);
}

void ImageAlbum::ZoomOut()
{
    ui->graphicsView->scale(0.8, 0.8);
}

void ImageAlbum::LeftRotate()
{
    ui->graphicsView->rotate(-45);
}

void ImageAlbum::RightRotate()
{
    ui->graphicsView->rotate(45);
}

void ImageAlbum::OrigImage()
{
    ui->graphicsView->resetTransform();
    imageView->graphicsScene->clear();
    imageView->graphicsScene->addPixmap(QPixmap(origImage->statusTip()).scaled(ui->graphicsView->width(), ui->graphicsView->height(),
                                                                               Qt::IgnoreAspectRatio, Qt::SmoothTransformation));
}

void ImageAlbum::selectItem(QListWidgetItem* item)
{
    origImage = item;
    selectImage = new QImage(ui->listWidget->currentItem()->statusTip());
    ui->graphicsView->resetTransform();
    imageView->graphicsScene->clear();
    imageView->graphicsScene->addPixmap(QPixmap(item->statusTip()).scaled(ui->graphicsView->width(), ui->graphicsView->height(),
                                                                          Qt::IgnoreAspectRatio, Qt::SmoothTransformation));

    qDebug() << selectImage->width();
}

void ImageAlbum::setImage(QString path)
{
    ui->graphicsView->resetTransform();
    imageView->graphicsScene->clear();
    imageView->graphicsScene->addPixmap(QPixmap(path).scaled(ui->graphicsView->width(), ui->graphicsView->height(),
                                                             Qt::IgnoreAspectRatio, Qt::SmoothTransformation));

    QFileInfo fileInfo(path);
    for(int i = 0; i < ui->listWidget->count(); i++) {
        if(ui->listWidget->item(i)->statusTip() == fileInfo.fileName()) {
            ui->listWidget->setCurrentRow(i);
            break;
        }
    }
}

QString ImageAlbum::currentImage()
{
    return (ui->listWidget->currentRow() >=0) ? ui->listWidget->currentItem()->statusTip() : "";
}

void ImageAlbum::reset()
{
    ui->graphicsView->resetTransform();
}

void ImageAlbum::VReverse()
{
    qDebug() << "Hi";
    imageView->graphicsScene->clear();
    QImage *image = new QImage(ui->listWidget->currentItem()->statusTip());
    image->mirror(true, false);

    QPixmap buf = QPixmap::fromImage(*image);
    ui->graphicsView->setScene(imageView->graphicsScene);
    imageView->graphicsScene->addPixmap(buf.scaled(ui->graphicsView->width(), ui->graphicsView->height(),
                                                   Qt::IgnoreAspectRatio, Qt::SmoothTransformation));
}

void ImageAlbum::HReverse()
{
    imageView->graphicsScene->clear();
    QImage *image = new QImage(ui->listWidget->currentItem()->statusTip());
    image->mirror(false, true);

    QPixmap buf = QPixmap::fromImage(*image);
    ui->graphicsView->setScene(imageView->graphicsScene);
    imageView->graphicsScene->addPixmap(buf.scaled(ui->graphicsView->width(), ui->graphicsView->height(),
                                                   Qt::IgnoreAspectRatio, Qt::SmoothTransformation));
}

void ImageAlbum::Brightness(int value)
{
    imageView->graphicsScene->clear();
    QImage *image = new QImage(ui->listWidget->currentItem()->statusTip());

    for(int x = 0; x < image->width(); ++x)
        for(int y = 0 ; y < image->height(); ++y) {
            const QRgb rgb = image->pixel(x, y);
            const double r = LIMIT_UBYTE(qRed(rgb) + value);
            const double g = LIMIT_UBYTE(qGreen(rgb) + value);
            const double b = LIMIT_UBYTE(qBlue(rgb) + value);
            image->setPixelColor(x, y,
                                 QColor(
                                     r,
                                     g,
                                     b));
        }
    //    QSize size = image->size();
    //    image->scaled(size);

    QPixmap buf = QPixmap::fromImage(*image);
    ui->graphicsView->setScene(imageView->graphicsScene);
    imageView->graphicsScene->addPixmap(buf.scaled(ui->graphicsView->width(), ui->graphicsView->height(),
                                                   Qt::IgnoreAspectRatio, Qt::SmoothTransformation));
}

void ImageAlbum::Gamma()
{
    imageView->graphicsScene->clear();
    QImage *image = new QImage(ui->listWidget->currentItem()->statusTip());

    for(int x = 0; x < image->width(); ++x)
        for(int y = 0 ; y < image->height(); ++y) {
            const QRgb rgb = image->pixel(x, y);
            const double r = qRed(rgb) / 255.0;
            const double g = qGreen(rgb) / 255.0;
            const double b = qBlue(rgb) / 255.0;
            image->setPixelColor(x, y,
                                 QColor(
                                     255 * std::pow(r, 1.5),
                                     255 * std::pow(g, 1.5),
                                     255 * std::pow(b, 1.5)));
        }

    QPixmap buf = QPixmap::fromImage(*image);
    ui->graphicsView->setScene(imageView->graphicsScene);
    imageView->graphicsScene->addPixmap(buf.scaled(ui->graphicsView->width(), ui->graphicsView->height(),
                                                   Qt::IgnoreAspectRatio, Qt::SmoothTransformation));
}

void ImageAlbum::Sobel()
{
    imageView->graphicsScene->clear();
    QImage *image = new QImage(ui->listWidget->currentItem()->statusTip());
//    QImage *out = image;

//    double *Gx = new double[9];
//    double *Gy = new double[9];

//    /* Sobel */
//    Gx[0] = 1.0; Gx[1] = 0.0; Gx[2] = -1.0;
//    Gx[3] = 2.0; Gx[4] = 0.0; Gx[5] = -2.0;
//    Gx[6] = 1.0; Gx[7] = 0.0; Gx[8] = -1.0;

//    Gy[0] = -1.0; Gy[1] = -2.0; Gy[2] = - 1.0;
//    Gy[3] = 0.0; Gy[4] = 0.0; Gy[5] = 0.0;
//    Gy[6] = 1.0; Gy[7] = 2.0; Gy[8] = 1.0;


//    QRgb pixel;
//    double value_gx,value_gy;
//    int width = image->width();
//    int height = image->height();
//    float sobel_norm[width * height];

//    float max=0.0;
//    QColor my_color;
//    for(int i = 0; i < image->width(); i++){
//        for(int j = 0; j < image->height(); j++){
//            value_gx=0.0;
//            value_gy=0.0;


//            for(int k = 0; k < 3; k++){
//                for(int p = 0; p < 3; p++){
//                    pixel=image->pixel((i+1+1-k),(j+1+1-p));
//                    value_gx += Gx[p*3+k]*qRed(pixel);
//                    value_gy += Gy[p*3+k]*qRed(pixel);
//                }//fin For P->3
//            }//fin For k->3
//            sobel_norm[i+j*image->width()]=sqrt(value_gx*value_gx + value_gy*value_gy)/1.0;
//            max = sobel_norm[i+j*image->height()]>max ? sobel_norm[i+j*image->width()]:max;
//        }
//    }

//    for(int i=0;i<image->width();i++){
//        for(int j=0;j<image->height();j++){
//            my_color.setHsv( 0 ,0, 255-int(255.0*sobel_norm[i + j * image->width()]/max));
//            out->setPixel(i,j,my_color.rgb());
//        }//fin For j
//    }//fin For i
























        QImage *out = image;

        int kx[3][3] = {{-1, 0 , 1},
                        {-2, 0, 2},
                        {-1, 0, 1}};
        int ky[3][3] = {{-1, -2, -1},
                        {0, 0, 0},
                        {1, 2, 1}};

        for(int y = 1; y < image->height()-1; y++){
            for(int x = 1; x < image->width()-1; x++){

                int a = (QColor(image->pixel(x-1,y-1)).red() + QColor(image->pixel(x-1,y-1)).blue()
                         + QColor(image->pixel(x-1,y-1)).green())/3;
                int b = (QColor(image->pixel(x,y-1)).red() + QColor(image->pixel(x,y-1)).blue()
                         + QColor(image->pixel(x,y-1)).green())/3;
                int c = (QColor(image->pixel(x+1,y-1)).red() + QColor(image->pixel(x+1,y-1)).green()
                         + QColor(image->pixel(x+1,y-1)).blue())/3;
                int d = (QColor(image->pixel(x-1,y)).blue() + QColor(image->pixel(x-1,y)).green()
                         + QColor(image->pixel(x-1,y)).red())/3;
                int e = (QColor(image->pixel(x,y)).green() + QColor(image->pixel(x,y)).red()
                         + QColor(image->pixel(x,y)).blue())/3;
                int f = (QColor(image->pixel(x+1,y)).blue() + QColor(image->pixel(x+1,y)).red()
                         + QColor(image->pixel(x+1,y)).green())/3;
                int g = (QColor(image->pixel(x-1,y+1)).green() + QColor(image->pixel(x-1,y+1)).red()
                         + QColor(image->pixel(x-1,y+1)).blue())/3;
                int h = (QColor(image->pixel(x,y+1)).blue() + QColor(image->pixel(x,y+1)).green()
                         + QColor(image->pixel(x,y+1)).red())/3;
                int i = (QColor(image->pixel(x+1,y+1)).red() + QColor(image->pixel(x+1,y+1)).green()
                         + QColor(image->pixel(x+1,y+1)).blue())/3;

                int matrix[3][3] = {{a, b, c},
                                    {d, e, f},
                                    {g, h, i}};
                int sumx = 0;
                int sumy = 0;

                for(int s = 0; s < 3; s++){
                    for(int t = 0; t < 3; t++){
                        sumx = sumx + (matrix[s][t] * kx[s][t]);
                        sumy = sumy + (matrix[s][t] * ky[s][t]); /* use ky, not kx */
                    }
                }
                int newValue = sqrt(pow(sumx, 2) + pow(sumy, 2));

                /* omitted, same as the original code */

                QColor test = QColor(image->pixel(x,y));

                test.setRed(newValue);
                test.setBlue(newValue);
                test.setGreen(newValue);

                out->setPixel(x, y, test.rgb()); /* modify out, not img */
            }
        }

    ////    image = out; /* filter calculation is done, so update img */

        QPixmap buf = QPixmap::fromImage(*out);
        ui->graphicsView->setScene(imageView->graphicsScene);
        imageView->graphicsScene->addPixmap(buf.scaled(ui->graphicsView->width(), ui->graphicsView->height(),
                                                       Qt::IgnoreAspectRatio, Qt::SmoothTransformation));
}

