/*
 * ImageUrlLoader.cpp
 *
 *  Created on: Mar 20, 2013
 *      Author: rsarmentopeixoto
 */

#include "ImageUrlLoader.h"

ImageUrlLoader::ImageUrlLoader() {
}

ImageUrlLoader::~ImageUrlLoader() {
}

QString ImageUrlLoader::imageUrl() {
	return m_imageUrl;
}

void ImageUrlLoader::setImageUrl(const QString& newUrl) {
    if (m_imageUrl != newUrl && newUrl != "") {
        m_imageUrl = newUrl;

        m_manager = new QNetworkAccessManager;
        this->loadImageUrl();
	}
}

void ImageUrlLoader::loadImageUrl() {
	if (m_manager) {
		qDebug() << "Load: " << qPrintable(m_imageUrl);
//		connect(m_manager, SIGNAL(dataReady(QByteArray)), this,
//				SLOT(imageLoaded(QByteArray)));
		//m_rpxNetwork.loadURL(QUrl(m_imageUrl));
		connect(m_manager, SIGNAL(finished(QNetworkReply*)), this,
				SLOT(replyFinished(QNetworkReply*)));
		m_manager->get(QNetworkRequest(m_imageUrl));
	}

}

QUrl redirectUrl(const QUrl& possibleRedirectUrl, const QUrl& oldRedirectUrl) {
	QUrl redirectUrl;
	/*
	 * Check if the URL is empty and
	 * that we aren't being fooled into a infinite redirect loop.
	 * We could also keep track of how many redirects we have been to
	 * and set a limit to it, but we'll leave that to you.
	 */
	if (!possibleRedirectUrl.isEmpty()
			&& possibleRedirectUrl != oldRedirectUrl) {
		redirectUrl = possibleRedirectUrl;
	}
	return redirectUrl;
}

void ImageUrlLoader::replyFinished(QNetworkReply * reply) {
	QVariant possibleRedirectUrl = reply->attribute(
			QNetworkRequest::RedirectionTargetAttribute);

	/* We'll deduct if the redirection is valid in the redirectUrl function */
	QUrl _urlRedirectedTo = redirectUrl(possibleRedirectUrl.toUrl(),
			reply->request().url());

	if (_urlRedirectedTo.isEmpty()) {

		disconnect(m_manager, SIGNAL(finished(QNetworkReply*)), this,
				SLOT(replyFinished(QNetworkReply*)));

        QStringList splitList = m_imageUrl.split("/");
        QString fileName(splitList.at(splitList.size() - 1));

        int i = 2;
        while (QFile::exists(QDir::currentPath() + "/tmp/" + fileName)) {
            QFileInfo fi(fileName);
            fileName = fi.baseName() + " (" + QString::number(i) + ")." + fi.completeSuffix();
            i++;
        }
        //      qDebug() << "ImageUrlLoader::setImageUrl:" << fileName;
        m_imagePath = QDir::currentPath() + "/tmp/" + fileName;

        m_file = new QFile("tmp/" + fileName);
		if (!m_file->open(QIODevice::WriteOnly | QIODevice::Append)) {
			qDebug() << "failed to open file";
			return;
		}
		m_file->write(reply->readAll());
		m_file->flush();
		m_file->close();

		//Its parent MUST have a imageSource property for being set
		this->parent()->setProperty("imageSource",
				QVariant::fromValue(QUrl(m_imagePath)));
		emit this->imageDone(m_imagePath);
        qDebug() << "ImageUrlLoader::replyFinished:" << QVariant::fromValue(QUrl(m_imagePath));
//		delete m_manager;
		m_manager = 0;
	} else {
		m_manager->get(QNetworkRequest(_urlRedirectedTo));
	}
}
