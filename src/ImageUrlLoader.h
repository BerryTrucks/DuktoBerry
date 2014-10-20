/*
 * ImageUrlLoader.h
 *
 *  Created on: Mar 20, 2013
 *      Author: rsarmentopeixoto
 */

#ifndef IMAGEURLLOADER_H_
#define IMAGEURLLOADER_H_

#include <qobject.h>
#include <bb/cascades/QmlDocument>
#include <QtNetwork/qnetworkaccessmanager.h>
#include <QtNetwork/qnetworkreply.h>

class ImageUrlLoader: public QObject {
	Q_OBJECT
	Q_PROPERTY(QString imageUrl READ imageUrl WRITE setImageUrl)
public:
	ImageUrlLoader();
	virtual ~ImageUrlLoader();
	static void registerQmlTypes() {
		qmlRegisterType<ImageUrlLoader>("utils.imageLoader", 1, 0, "ImageUrlLoader");
	}
	void loadImageUrl();
	Q_INVOKABLE QString imageUrl();
	Q_INVOKABLE void setImageUrl(const QString& newUrl);
signals:
		void imageDone(const QString& currentPath);
public slots:
		void replyFinished(QNetworkReply*);
private:
		QNetworkAccessManager * m_manager;
	    QFile * m_file;
	    QString m_imageUrl;
	    QString m_imagePath;
};

#endif /* IMAGEURLLOADER_H_ */
