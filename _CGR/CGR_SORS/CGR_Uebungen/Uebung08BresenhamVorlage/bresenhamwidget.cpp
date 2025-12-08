#include "bresenhamwidget.h"
#include <cmath>
#include <qpainter.h>
#include <qdebug.h>

void BresenhamWidget::paintEvent(QPaintEvent *event)
{
    Q_UNUSED(event);
    //create a QPainter and pass a pointer to the device.
    //A paint device can be a QWidget, a QPixmap or a QImage
    QPainter painter(this);
    QPen pen(QColor(0,255,0));
    painter.setPen(pen);
    //painter.setCompositionMode(QPainter::RasterOp_SourceOrDestination);
    mImage->fill(0);
    if (mOwnLine)
        RenderLine2D(QPoint(0,0), QPoint(mSize-1,mSize/2-1));
    if (mOwnCircle)
        DrawCircleMidPoint(QPoint(200,200), QPoint(200,300));
    painter.drawImage(QPoint(0,0), *mImage);
    if (mQtCircle)
    {
            QRectF rectangle(100.0, 100.0, 200.0, 200.0);
            painter.drawArc(rectangle, 0, 16 * 360);
    }
    if (mQtLine)
    {
        painter.drawLine(0,0,mSize-1, mSize/2-1);
    }
}

void BresenhamWidget::RenderLine2D(QPoint start, QPoint end)
{
    // draw always from lower to higher x pos
    if(start.x() > end.x())
        std::swap(start, end);

    int deltaX = end.x() - start.x();
    int deltaY = end.y() - start.y();

    //delta y have to be lower then delta x. swap if necessary
    bool dimensionSwap = false;
    if(deltaX < deltaY) {
        dimensionSwap = true;
        std::swap(deltaX, deltaY);
        QPoint tmp(start.y(), start.x());
        start = tmp;
        tmp.setX(end.y());
        tmp.setY(end.x());
        end = tmp;

    }
    int doubleDeltaX = 2 * deltaX;
    int deltaAmountY = abs(deltaY);
    int doubleDeltaAmountY = 2 * deltaAmountY;

    int stepY = deltaY >= 0 ? 1 : -1;

    int err = 2 * deltaAmountY - deltaX;
    int y = start.y();
    for (int x = start.x(); x <= end.x(); x++)
    {
        if(err >= 0) {
            y += stepY;
            err = err - doubleDeltaX;
        }
        err = err + doubleDeltaAmountY;
        if(!dimensionSwap)
            mImage->setPixel(x, y, mDrawColor);
        else
            mImage->setPixel(y, x, mDrawColor);
    }
}

//! Zeichnet Kreis in die bitplane
//! center: Mittelpunkt; outer: Pkt auf Kreisbogen
void BresenhamWidget::DrawCircleMidPoint(QPoint center, QPoint outer) {
//Hier Berechnung des Kreises einfügen
}

BresenhamWidget::BresenhamWidget(QWidget *parent) :
    QWidget(parent)
{
    mSize = 400;
    mImage = new QImage(400, 600, QImage::Format_RGB32);
    QColor lC(255,0,0);
    mDrawColor = lC.rgb();
    mOwnCircle=mOwnLine=mQtCircle=mQtLine=false;
}
