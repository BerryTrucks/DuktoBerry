/*
 * RecentModel.cpp
 *
 *  Created on: 18/10/2014
 *      Author: laairoy
 */

#include <RecentModel.h>
#include <QDateTime>

RecentModel::RecentModel()
{
    // TODO Auto-generated constructor stub

}

RecentModel::~RecentModel()
{
    // TODO Auto-generated destructor stub
}

void RecentModel::addRecent(QString name, QString value, QString type, QString sender, qint64 size)
{
    QVariantMap it;

    // Format timestamp
    QDateTime now = QDateTime::currentDateTime();
    QString datetime = now.toString(Qt::SystemLocaleShortDate);

    // Convert size data
    QString sizeFormatted;
    if (size < 1024)
        sizeFormatted = QString::number(size) + " B";
    else if (size < 1048576)
        sizeFormatted = QString::number(size * 1.0 / 1024, 'f', 1) + " KB";
    else
        sizeFormatted = QString::number(size * 1.0 / 1048576, 'f', 1) + " MB";

    // Icon
    if (type == "text")
        it["typeIcon"] = "asset:///images/RecentText.png";
    else if (type == "file")
        it["typeIcon"] = "asset:///images/RecentFile.png";
    else
        it["typeIcon"] = "asset:///images/RecentFiles.png";

    if (type == "text")
        it["name"] = name;
    else
        it["name"] = name + " (" + sizeFormatted + ")";

    it["value"] = value;
    it["type"] = type;
    it["dateTime"] = datetime;
    it["sender"] = sender;
    it["size"] = sizeFormatted;
    insert(it);
}
