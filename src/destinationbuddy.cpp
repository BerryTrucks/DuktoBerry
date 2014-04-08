/* DUKTO - A simple, fast and multi-platform file transfer tool for LAN users
 * Copyright (C) 2011 Emanuele Colombo
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

#include "destinationbuddy.h"

#include "model/BuddyModel.h"

#include <bb/cascades/DataModel>

DestinationBuddy::DestinationBuddy(QObject *parent) :
    QObject(parent)
{
}

void DestinationBuddy::fillFromItem(QVariantMap item)
{
    mIp = item.value("ip").toString();
    mPort = item.value("port").toInt();
    mUsername = item.value("username").toString();
    mSystem = item.value("system").toString();
    mPlatform = item.value("platform").toString();
    mGenericAvatar = item.value("generic").toString();
    mAvatar = item.value("avatar").toString();
    mOsLogo = item.value("oslogo").toString();
    mShowBack = item.value("showback").toString();
    emit ipChanged();
    emit portChanged();
    emit usernameChanged();
    emit systemChanged();
    emit platformChanged();
    emit genericAvatarChanged();
    emit avatarChanged();
    emit osLogoChanged();
    emit showBackChanged();
}

